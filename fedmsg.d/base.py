import os

config = dict(
    environment=os.environ['ENVIRONMENT'],
    zmq_enabled=False,
    stomp_uri=os.environ['UMB_URI'],
    stomp_heartbeat=1000,
    stomp_ssl_crt='/secrets/cert',
    stomp_ssl_key='/secrets/key',
    stomp_ack_mode='client-individual',
)
config['moksha.blocking_mode'] = True
