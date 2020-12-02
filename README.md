# A container for running datagrepper

This repository contains configuration and supporting files for running
[datagrepper](https://github.com/fedora-infra/datagrepper) in a container.
The image is built on top of a [Fedora](https://hub.docker.com/_/fedora) base
image.

## Build

To build the container in OpenShift, you can run:
```bash
oc new-build https://github.com/release-engineering/datagrepper-container
```

## Deployment

The recommended deployment method is OpenShift.

### Configuration

All configuration of the image is handled via environment variables,
provided by your container runtime environment.

- ENVIRONMENT: the environment the datagrepper instance is running in,
  usually `dev`, `stg`, or `prod` (default: dev)
- DB_HOST: the host where the `datanommer` database is located
- DB_NAME: the name of the `datanommer` database
- DB_USERNAME: the username to connect to the `datanommer` database
- DB_PASSWORD: the password to connect to the `datanommer` database
- DEFAULT_QUERY_DELTA: the default delta to set on queries
- LOGLEVEL: what level of logging to use (default: WARNING)
