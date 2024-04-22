from requests import Request, Session
import logging
import settings

logger = logging.getLogger(settings.LOGGER_NAME)

class HttpClient(object):
	"""wraps and sends data to whatever mgsv server you want"""
	def __init__(self):
		super(HttpClient, self).__init__()

	def send(self, data, _url, base_url='https://mgstpp-game.konamionline.com'):
		url = base_url + _url
		payload = {"httpMsg": str(data)}
		headers = {"Content-Type": "application/x-www-form-urlencoded", "Connection":"Keep-Alive"}

		s = Session()
		req = Request('POST', url, data=payload, headers=headers)
		logger.info("Url: {}".format(url))
		logger.info("Data: {}".format(data))
		prepped = req.prepare()
		response = s.send(prepped)
		logger.info("Request response: {}".format(response.text))
		return response