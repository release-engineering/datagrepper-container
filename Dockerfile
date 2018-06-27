FROM fedora:28
LABEL \
    name="datagrepper" \
    vendor="Factory 2.0" \
    license="GPLv3"
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "-w", "4", "--access-logfile", "-", "datagrepper.app:app"]
EXPOSE 8080
COPY repos/ /etc/yum.repos.d/
RUN dnf -y install \
        python2-gunicorn
        datagrepper \
        python2-fedmsg-meta-umb \
        python-fedmsg-meta-umb-docs \
        python2-psycopg2 && \
    dnf -y clean all
RUN rm -f /etc/fedmsg.d/*
COPY fedmsg.d/ /etc/fedmsg.d/
RUN echo "DATAGREPPER_DOC_PATH='/usr/share/doc/python-fedmsg-meta-umb-docs/datagrepper-docs'" >> /etc/datagrepper/datagrepper.cfg
COPY send_umb_docs.py /var/tmp
RUN cat /var/tmp/send_umb_docs.py >> /usr/lib/python2.7/site-packages/datagrepper/app.py
USER 1001
