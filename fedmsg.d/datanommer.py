import os

DB_HOST     = os.environ['DB_HOST']
DB_NAME     = os.environ['DB_NAME']
DB_USERNAME = os.environ['DB_USERNAME']
DB_PASSWORD = os.environ['DB_PASSWORD']

config = {
    'datanommer.enabled': True,
    'datanommer.sqlalchemy.url': 'postgresql://{0}:{1}@{2}/{3}'.format(DB_USERNAME,
                                                                       DB_PASSWORD,
                                                                       DB_HOST,
                                                                       DB_NAME),
    'datanommer.topic': os.environ['DATANOMMER_TOPIC'],

    'content_security_policy': 'connect-src https://*.int.open.paas.redhat.com wss://*.int.open.paas.redhat.com',

    'datagrepper_logo': 'static/datagrepper-debranded.png',
    'theme_css_url': 'static/pnt-bootstrap.min.css',
    'message_bus_docs': 'https://mojo.redhat.com/docs/DOC-1072237',
    'message_bus_shortname': 'UMB',
    'message_bus_longname': 'Unified Message Bus (UMB)',
}
