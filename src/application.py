import os

from dotenv import load_dotenv
from flask import Flask, jsonify

import funtions as f

load_dotenv()
application = Flask(__name__)
data = f.load_file('./src/heroes.csv')


@application.route("/")
def index():
    return jsonify(data)


@application.route("/favicon.ico")
def favicon():
    return "", 204


@application.route("/<string:id>")
def heroe(id):
    if id in data:
        return jsonify(data[id])
    else:
        return jsonify({"error": "Hero not found"}), 404


if __name__ == "__main__":
    PORT: int = int(os.getenv('PORT', default='5002'))
    application.run(host="0.0.0.0", port=PORT, debug=True)
