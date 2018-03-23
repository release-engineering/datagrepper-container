import os

config = dict(
    environment=os.environ.get('ENVIRONMENT', 'dev'),
    zmq_enabled=False,
)
