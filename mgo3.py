from flask import Flask, request, Response, make_response
import os
import sys
sys.path.append(os.path.dirname(__file__))
from CommandProcessor import CommandProcessor
import urllib.parse
from Logger import create_logger

app = Flask(__name__)
logger = create_logger('mgsv')

# Assuming the app directory structure keeps the 'www' folder at the same level as this script
EULA_DIR = os.path.join(os.path.dirname(__file__), 'www', 'tppstmweb', 'eula')

@app.route('/', methods=['POST', 'GET'])
@app.route('/<path:path>', methods=['POST', 'GET'])
def handle_request(path=''):
    if request.method == 'POST':
        processor = CommandProcessor()
        data = request.get_data(as_text=True)
        d = urllib.parse.parse_qs(data, True)
        client_request = d.get('httpMsg', [''])[0]

        logger.debug(f'New client request: {client_request}')
        output = processor.process(client_request)
        logger.debug(f'Encoded response from processor: {str(output)}')
        return Response(output, mimetype='text/plain')

    elif request.method == 'GET' and path == 'tppstmweb/eula/eula.var':
        file_path = os.path.join(EULA_DIR, 'eula.var')
        if os.path.exists(file_path):
            with open(file_path, 'r') as file:
                file_content = file.read()
            response = make_response(file_content)
            response.headers['Content-Type'] = 'text/plain; charset=utf-8'
            return response
        else:
            return "File not found", 404

    elif request.method == 'GET' and path == 'tppstmweb/coin/coin.var':
        file_path = os.path.join(EULA_DIR, 'eula.var')
        if os.path.exists(file_path):
            with open(file_path, 'r') as file:
                file_content = file.read()
            response = make_response(file_content)
            response.headers['Content-Type'] = 'text/plain; charset=utf-8'
            return response
        else:
            return "File not found", 404

    elif request.method == 'GET' and path == 'tppstmweb/gdpr/gdpr.var':
        file_path = os.path.join(EULA_DIR, 'eula.var')
        if os.path.exists(file_path):
            with open(file_path, 'r') as file:
                file_content = file.read()
            response = make_response(file_content)
            response.headers['Content-Type'] = 'text/plain; charset=utf-8'
            return response
        else:
            return "File not found", 404

    elif request.method == 'GET' and path == 'tppstmweb/privacy/privacy.var':
        file_path = os.path.join(EULA_DIR, 'eula.var')
        if os.path.exists(file_path):
            with open(file_path, 'r') as file:
                file_content = file.read()
            response = make_response(file_content)
            response.headers['Content-Type'] = 'text/plain; charset=utf-8'
            return response
        else:
            return "File not found", 404

    elif request.method == 'GET' and path == 'tppstmweb/privacy_jp/privacyjp.var':
        file_path = os.path.join(EULA_DIR, 'eula.var')
        if os.path.exists(file_path):
            with open(file_path, 'r') as file:
                file_content = file.read()
            response = make_response(file_content)
            response.headers['Content-Type'] = 'text/plain; charset=utf-8'
            return response
        else:
            return "File not found", 404



    return Response('This method is not supported.', status=405)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
