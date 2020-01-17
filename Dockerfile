FROM fedora:31

LABEL \
    name="datagrepper" \
    vendor="Factory 2.0" \
    license="GPLv3"

ENTRYPOINT ["gunicorn-3"]
CMD ["datagrepper.app:app"]
ENV GUNICORN_CMD_ARGS="--bind=0.0.0.0:8080 --workers=4 --access-logfile=-"

ENV DNF_CMD="dnf -y --setopt=deltarpm=0 --setopt=install_weak_deps=false"
ENV EXTRA_RPMS="python3-fedmsg-meta-umb python-fedmsg-meta-umb-doc"

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
COPY static/ /usr/lib/python3.7/site-packages/datagrepper/static/

USER 1001
