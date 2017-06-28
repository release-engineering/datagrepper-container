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
}
