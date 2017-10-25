
from flask import send_from_directory
import os.path

@app.route('/umb/', defaults={'path': 'index.html'})
@app.route('/umb/<path:path>')
def send_umb_docs(path):
    dirpath = os.path.dirname(__file__) + '/umb'
    return send_from_directory(dirpath, path)
