import os

# Setup fedmsg logging.
# See the following for constraints on this format https://bit.ly/Xn1WDn
bare_format = "[%(asctime)s][%(name)10s %(levelname)7s] %(message)s"

config = dict(
    logging=dict(
        version=1,
        formatters=dict(
            bare={
                "datefmt": "%Y-%m-%d %H:%M:%S",
                "format": bare_format
            },
        ),
        handlers=dict(
            console={
                "class": "logging.StreamHandler",
                "formatter": "bare",
                "level": os.environ.get("LOGLEVEL", "WARNING"),
                "stream": "ext://sys.stdout",
            },
        ),
        loggers=dict(
            fedmsg={
                "level": os.environ.get("LOGLEVEL", "WARNING"),
                "propagate": False,
                "handlers": ["console"],
            },
            moksha={
                "level": os.environ.get("LOGLEVEL", "WARNING"),
                "propagate": False,
                "handlers": ["console"],
            },
            stomper={
                "level": os.environ.get("LOGLEVEL", "WARNING"),
                "propagate": False,
                "handlers": ["console"],
            },
            datanommer={
                "level": os.environ.get("LOGLEVEL", "WARNING"),
                "propagate": False,
                "handlers": ["console"],
            },
        ),
    ),
)
