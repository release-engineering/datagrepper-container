
from flask import send_from_directory

@app.route('/umb/<path:path>')
def send_umb_docs(path):
    return send_from_directory('umb', path)
