from Blowfish import Blowfish
import base64
import struct
import json
import zlib
import sys
import platform
import settings
import logging
logger = logging.getLogger(settings.LOGGER_NAME)

DECODE_PACK = '>l'
if platform.system() == 'Linux' and sys.maxsize > 2**32:
        DECODE_PACK = '>L'

# D:\Users\unknown\Desktop\WiresharkPortable\App\Wireshark\tshark.exe -r J:\mgs\ssl\dump_with_a_key.cap.pcap -o ssl.keys_list:"0.0.0.0","443","http","D:\Users\unknown\Desktop\OZH.pem" -2  -Y "ip.addr == 210.149.133.135 and http" -T fields -e http.file_data > C:\testout.txt
# replace %2B with +
# remove ',' and line breaks

class Decoder(object):
        """class for decoding messages sent from server to client
        this is a great example of complicated non-pythonic class

        how it _should_ be: get already decoded bytestring (not base64 encoded),
        decode it with provided key and return bytestring. Json conversation,
        zlib decompression etc should be done outside of this class, but hey, it
        works"""
        def __init__(self, static_key=None, crypto_key=None):
                # try to initialize static part without explicitly provided static key
                self.__static_blowfish = Blowfish()
                if not static_key:
                        static_key = bytearray(open(settings.STATIC_KEY_FILE_PATH,'rb').read(16))

#================= a dirty hack for debugging
#              crypto_key = bytearray(base64.decodebytes('AAAAAAAAAAAAAAAAAAAAAA=='.encode()))
#================= remove dirty hack
                self.__static_blowfish.initialize(static_key)

                self.__session_blowfish = None
                self.__crypto_key = None

                if crypto_key:
                        # this is an encrypted session with provided crypto key
                        # need an instance of blowfish capable of decoding it
                        self.__crypto_key = crypto_key
                        self.__init_session_blowfish__()

        def __get_crypto_key__(self, data):
                # try to pull crypto_key from json
                crypto_key = None
                if 'data' in data:
                        if isinstance(data['data'], dict):
                                if 'crypto_key' in data['data']:
                                        if len(data['data']['crypto_key']) > 0:
                                                crypto_key = bytearray(base64.decodebytes(data['data']['crypto_key'].encode()))
                                                self.__crypto_key = crypto_key
                return crypto_key

        def __init_session_blowfish__(self, crypto_key=None):
                # initialize bowfish instance capable of decoding session data
                self.__session_blowfish = Blowfish()
                if crypto_key:
                        if isinstance(crypto_key, str):
                                crypto_key = bytearray(base64.decodebytes(crypto_key.encode()))
                        self.__crypto_key = crypto_key
                self.__session_blowfish.initialize(self.__crypto_key)

        def __get_json__(self, text):
                # TODO: this breaks proxying of CMD_STEAM_AUTH
                text = text[:text.rfind('}')+1]
                text = text.replace('\\\\r\\\\n','')
                text = text.replace('\\r\\n','')
                text = text.replace('\\','')
                text = text.replace('"{','{')
                text = text.replace('}"','}')
                text = json.loads(text)
                return text

        def __decipher__(self, blow, data):
                # read data in chunks with size of 8 and decode them using corresponding 
                # blowfish instance
                offset = 0
                full_text = bytes()
                while offset!= len(data):
                        chunk = data[offset:offset+8]
                        x = struct.unpack(DECODE_PACK,chunk[0:4])[0]
                        y = struct.unpack(DECODE_PACK, chunk[4:8])[0]
                        x,y = blow.blowfish_decipher(x, y)

                        x_text = struct.pack(DECODE_PACK,x)
                        y_text = struct.pack(DECODE_PACK,y)

                        full_text += x_text + y_text
                        offset = offset+8
                return full_text

        def decode(self, data):
                # accepts base64-encoded strings from server
                # you need to remove all line breaks, commas and html-escapes before decoding
                encoded_text = None
                try:
                        data_encoded = base64.decodebytes(data.encode())
                except Exception as e:
                        raise e
                else:
                        data_decoded = self.__decipher__(self.__static_blowfish, data_encoded)
                        logger.debug('Decoded data: {}'.format(data_decoded))

                try:
                        # json conversions can be wonky
                        data_json = self.__get_json__(data_decoded.decode())
                except Exception as e:
                        raise e

                if not self.__session_blowfish:
                        # there was no crypto_key set during instance initialization for whatever 
                        # reason, so let's try to pull it from json
                        # this is a workaround for requauth_https I think
                        self.__get_crypto_key__(data_json)
                        if self.__crypto_key:
                                self.__init_session_blowfish__()

                if data_json['session_crypto']:
                        if self.__session_blowfish:
                                # COMPOUND encryption with blowfish
                                embedded = base64.decodebytes(data_json['data'].encode())
                                data_json['data'] = self.__decipher__(self.__session_blowfish, embedded)
                                if data_json['compress']:
                                        data_json['data'] = zlib.decompress(data_json['data'])
                        else:
                                # encryption is used, but we have no session key
                                # this is ok, since we need to get enc key from mysql using session id
                                pass
                else:
                        # no encryption, used in CMD_GET_URLLIST and others before getting session key
                        if data_json['compress']:
                                data_json['data'] = zlib.decompress(base64.decodebytes(data_json['data'].encode()))

                if isinstance(data_json['data'], bytes):
                        data_json['data'] = data_json['data'].decode(errors='ignore')

                if 'original_size' in data_json and isinstance(data_json['data'], str):
                        # remove padding and convert to json
                        data_json['data'] = data_json['data'][:data_json['original_size']]
                        try:
                                j = json.loads(data_json['data'])
                        except Exception as e:
                                # not json, skipping
                                pass
                        else:
                                data_json['data'] = j
                return data_json
