import os

config = dict(
    environment=os.environ["ENVIRONMENT"],
    zmq_enabled=False,
    endpoints={},
    validate_signatures=False,
)
