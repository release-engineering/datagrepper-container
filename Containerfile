FROM registry.fedoraproject.org/fedora:latest

ENV DATAGREPPER_VERSION="0.9.7"
ENV FEDMSG_META_UMB_VERSION="0.0.4"

LABEL name="datagrepper" \
      version="$DATAGREPPER_VERSION" \
      vendor="Red Hat EXD Software Production" \
      license="GPL-2.0-or-later" \
      org.opencontainers.image.title="datagrepper" \
      org.opencontainers.image.version="$DATAGREPPER_VERSION" \
      org.opencontainers.image.description="datagrepper in a container, suitable for running on OpenShift" \
      org.opencontainers.image.vendor="Red Hat EXD Software Production" \
      org.opencontainers.image.authors="EXD Messaging Guild <exd-guild-messaging@redhat.com>" \
      org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.url="https://github.com/release-engineering/datagrepper-container" \
      org.opencontainers.image.source="https://github.com/release-engineering/datagrepper-container" \
      org.opencontainers.image.documentation="https://github.com/fedora-infra/datagrepper" \
      distribution-scope="public"

CMD ["gunicorn-3", "datagrepper.app:app"]
ENV GUNICORN_CMD_ARGS="--bind=0.0.0.0:8080 --workers=4 --access-logfile=-"

ENV DNF_CMD="dnf -y --setopt=install_weak_deps=0"
ENV EXTRA_RPMS="python3-fedmsg-meta-umb python-fedmsg-meta-umb-doc"
ENV PYTHON_VERSION="3.9"

EXPOSE 8080

COPY repos/ /etc/yum.repos.d/
RUN $DNF_CMD install \
        datagrepper \
        python3-gunicorn \
        python3-psycopg2 \
        nginx \
        $EXTRA_RPMS && \
    $DNF_CMD clean all

RUN rm -f /etc/fedmsg.d/*
COPY fedmsg.d/ /etc/fedmsg.d/

COPY datagrepper.cfg /etc/datagrepper/
COPY static/ /usr/lib/python${PYTHON_VERSION}/site-packages/datagrepper/static/

USER 1001
