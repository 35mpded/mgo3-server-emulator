from Invoker import Invoker
from Receiver import Receiver
from CommandParser import CommandParser
from Encoder import Encoder
from Decoder import Decoder
from Database import Database
import settings
import importlib

import logging
logger = logging.getLogger('mgsv')


class CommandProcessor:
    def __init__(self):
        pass

    def parse_request(self,request):
        pass

    def process(self, request):
        result = None
        decoder = Decoder()
        encoder = Encoder()
        decoded_request = decoder.decode(request)
        if decoded_request['session_crypto']:
            db = Database()
            db.connect()
            player = db.get_player_by_session_id(decoded_request['session_key'])
            if not isinstance(player, dict):
                # not a dict, list or None
                logger.info('Found {} players with session_key {}'.format(len(player), decoded_request['session_key']))
                return result

            encoder.__init_session_blowfish__(player['crypto_key'])
            decoder.__init_session_blowfish__(player['crypto_key'])
            decoded_request = decoder.decode(request)

        logger.debug('Decoded request: {}'.format(decoded_request))

        parser = CommandParser()
        command_name = parser.parse_name(decoded_request)
        command_data = parser.parse_data(decoded_request)
        logger.info('Got a command: {}'.format(command_name))
        if False:#settings.PROXY_ALL or command_name in settings.PROXY_ALWAYS:
            proxy = Proxy()
            if decoded_request['session_crypto']:
                result = proxy.send_data_with_auth(request, command_name, command_data, player)
            else:
                result = proxy.send_data(request, command_name, command_data)
        else:
            mod = __import__('server.command.{}'.format(command_name), fromlist=[command_name])
            command = getattr(mod, command_name)
            receiver = Receiver(decoded_request['session_key'])
            my_command = command(receiver)
            invoker = Invoker()
            invoker.store_command(my_command)
            invoker.store_data(command_data)
            execution_result = invoker.execute_commands()

            logger.info('Execution result: {}'.format(str(execution_result)))

            # there is only one command per request 
            result = encoder.encode(execution_result[command_name])
        return result
