#!/usr/bin/python3
import a2s
import json
from http.server import BaseHTTPRequestHandler, HTTPServer
from concurrent import futures

class Server(BaseHTTPRequestHandler):
	def do_GET(self):
		self.send_response(200)
		self.send_header('Content-type', 'application/json')
		self.end_headers()
		new_d = {}
		with futures.ThreadPoolExecutor(max_workers=1) as executor:
			new_d["status"] = "on"
			try:
				future = executor.submit(a2s.info, ("localhost", 2457))
				d = dict(future.result(1))
				for key in ["player_count", "bot_count"]:
					new_d[key] = d[key]
			except futures._base.TimeoutError:
				new_d["status"] = "off"
				new_d["player_count"] = 0
				new_d["bot_count"] = 0
		self.wfile.write(json.dumps(new_d).encode())

def run():
	server = HTTPServer(("", 10093), Server)
	server.serve_forever()

run()
