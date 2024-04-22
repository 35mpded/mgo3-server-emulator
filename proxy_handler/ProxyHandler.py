import logging
from .. import settings
from Invoker import Invoker
from Receiver import Receiver
logger = logging.getLogger(settings.LOGGER_NAME)


class ProxyHandler(object):
    """
    A class which executes functions before and after proxying the main function
    """
    def __init__(self, command_name, command_data, player=None):
        self._command_name = command_name
        self._command_data = command_data
        self._player = player

    def _get_function(self, ftype):
        result = None
        logger.debug('Looking for command {}'.format(self._command_name))
        try:
            mod = __import__('mgsv_emulator.proxy_handler.command.{}'.format(self._command_name),
                    fromlist=["PROXY_PRE_{}".format(self._command_name)])
        except Exception as e:
            logger.debug('Cannot import module {}: {}'.format(self._command_name, str(e)))
        else:
            try:
                command = getattr(mod, "{}{}".format(ftype, self._command_name))
            except Exception as e:
                logger.debug('Cannot import function {}{}'.format(ftype,self._command_name))
            else:
                if callable(command):
                    result = command
        return result

    def preprocess(self):
        command = self._get_function("PROXY_PRE_")
        command.execute(data=self._command_data)

    def postprocess(self, _data=None, _request_data=None):
        """
        executes function with 2 params:
            data: response of server;
            request_data: client's request
        """
        command = self._get_function("PROXY_POST_")
        command.execute(data=_data, request_data=_request_data)
