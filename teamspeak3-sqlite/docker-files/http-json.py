#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse
import json
import requests

def cast_json_quoted_numbers(obj):
    if type(obj)==type({}):
        for key, value in obj.items():
            obj[key] = cast_json_quoted_numbers(value)
        return obj
    if type(obj)==type([]):
        for i in range(0, len(obj)):
            obj[i] = cast_json_quoted_numbers(obj[i])
        return obj
    if not type(obj)==type(""):
        return obj
    if obj.isdigit():
        return int(obj)
    if obj.replace('.','',1).isdigit():
        return float(obj)

def read_upstream():
    r = requests.get(url)
    return json.loads(r.text)

class RequestHandler(BaseHTTPRequestHandler):
    
    def do_GET(self):
        parsed_path = urlparse(self.path)
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        dictionary = read_upstream()
        cast_json_quoted_numbers(dictionary)
        self.wfile.write(json.dumps(dictionary).encode())
        return

if __name__ == '__main__':
    with open("upstream.json", "r") as file:
        url = json.load(file)
    server = HTTPServer(('0.0.0.0', 10081), RequestHandler)
    server.serve_forever()