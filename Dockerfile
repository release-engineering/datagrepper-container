FROM registry.fedoraproject.org/fedora-minimal:33

LABEL name="datagrepper" \
      vendor="Red Hat EXD Software Production" \
      license="GPL-2.0-or-later" \
      org.opencontainers.image.title="datagrepper" \
      org.opencontainers.image.description="datagrepper in a container, suitable for running on OpenShift" \
      org.opencontainers.image.vendor="Red Hat EXD Software Production" \
      org.opencontainers.image.authors="EXD Messaging Guild <exd-guild-messaging@redhat.com>" \
      org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.url="https://github.com/release-engineering/datagrepper-container" \
      org.opencontainers.image.source="https://github.com/release-engineering/datagrepper-container" \
      org.opencontainers.image.documentation="https://github.com/fedora-infra/datagrepper" \
      distribution-scope="public"

ENTRYPOINT ["gunicorn-3"]
CMD ["datagrepper.app:app"]
ENV GUNICORN_CMD_ARGS="--bind=0.0.0.0:8080 --workers=4 --access-logfile=-"

ENV DNF_CMD="microdnf --setopt=install_weak_deps=0"
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

# fedora-minimal removes zoneinfo files to save space, but
# pytz expects zone.tab to exist. Create an empty zone.tab
# to prevent (non-fatal) tracebacks on service startup.
RUN mkdir -p /usr/share/zoneinfo && touch /usr/share/zoneinfo/zone.tab

USER 1001
