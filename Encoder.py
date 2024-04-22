# -*- coding: utf-8 -*-
from Blowfish import Blowfish
import base64
import struct
import json
import zlib
import warnings
#from .. import settings
import settings
import sys
import platform

#from .. import settings
import logging
logger = logging.getLogger(settings.LOGGER_NAME)

ENCODE_PACK = '>l'
if platform.system() == 'Linux' and sys.maxsize > 2**32:
	ENCODE_PACK = '>L'

class Encoder(object):
	"""another example of bad class - see notes for decoder"""
	def __init__(self, static_key=None, crypto_key=None):
		self.__static_blowfish = Blowfish()
		if not static_key:
			static_key = bytearray(open(settings.STATIC_KEY_FILE_PATH,'rb').read(16))
		self.__static_blowfish.initialize(static_key)

		self.__session_blowfish = None
		self.__crypto_key = None
		if crypto_key:
			self.__crypto_key = crypto_key
			self.__init_session_blowfish__()

	def __init_session_blowfish__(self, crypto_key=None):
		self.__session_blowfish = Blowfish()
		if crypto_key:
			if isinstance(crypto_key, str):
				crypto_key = bytearray(base64.decodebytes(crypto_key.encode()))
			self.__crypto_key = crypto_key
		self.__session_blowfish.initialize(self.__crypto_key)

	def __encipher__(self, blow, data):
		offset = 0
		full_text = bytes()
		while offset!= len(data):
			chunk = data[offset:offset+8]
			if isinstance(chunk, str):
				x = struct.unpack(ENCODE_PACK,chunk[0:4].encode())[0]
				y = struct.unpack(ENCODE_PACK, chunk[4:8].encode())[0]
			else:
				x = struct.unpack(ENCODE_PACK,chunk[0:4])[0]
				y = struct.unpack(ENCODE_PACK, chunk[4:8])[0]

			x,y = blow.blowfish_encipher(x, y)

			x_text = struct.pack(ENCODE_PACK,x)
			y_text = struct.pack(ENCODE_PACK,y)

			full_text += x_text + y_text
			offset = offset+8
		return full_text

	def __add_padding__(self, text):
		if len(text)%8!=0:
			x = bytes([8-len(text)%8])*(8-len(text)%8)
			if isinstance(text,str):
				text = text.encode() + x
			else:
				text = text + x
		return text

	def __compress_data__(self, data):
		text = json.dumps(data, sort_keys=True)
		# this will also replace all stuff in VALUES, which can be a big deal
		text = text.replace(', ',',')
		text = text.replace(': ',':')
		return text

	def encode(self, _command):
		if type(_command) != dict:
			# result of command processing wasn't dict - this is not acceptable
			warnings.warn('You are using plain text, parameters might be not in the right order!', Warning, stacklevel=2)
			return ""

		# encrypt everything inside command
		if (type(_command) == dict) and ('data' in _command):
			# remove spaces, replace quotes, like C does + calculate new size
			_command['data'] = self.__compress_data__(_command['data'])
			logger.debug('Compressed data: {}'.format(_command['data']))
			_command['original_size'] = len(_command['data'])

			if _command['compress'] and not _command['session_crypto']:
				_command['data'] = base64.encodebytes(zlib.compress(_command['data'].encode())).decode()
				_command['data'] = _command['data'].replace('\n','\r\n')

			if _command['session_crypto']:
				if _command['compress']:
					_command['data'] = zlib.compress(_command['data'].encode())
					# game adds redundant padding (8 bytes even if len%8=0)
					_command['data'] = self.__add_padding__(_command['data'])
				else:
					_command['data'] = self.__add_padding__(_command['data'])
				_command['data'] = base64.encodebytes(self.__encipher__(self.__session_blowfish, _command['data'])).decode()
				_command['data'] = _command['data'].replace('\n','\r\n').rstrip('\r\n')

		text = json.dumps(_command,sort_keys=True).replace(" ",'')
		text = self.__add_padding__(text.encode())
		text = base64.encodebytes(self.__encipher__(self.__static_blowfish, bytearray(text)))
		text = text.decode().replace('\n','\r\n').rstrip('\r\n')
		return text
