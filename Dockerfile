FROM centos:7
LABEL \
    name="datagrepper instance for the Unified Message Bus (UMB)" \
    vendor="Factory 2.0" \
    license="GPLv3"
CMD ["gunicorn", \
     "--bind", "0.0.0.0:8080", \
     "-w", "4", \
     "--access-logfile", "-", \
     "datagrepper.app:app"]
EXPOSE 8080
RUN yum -y install python-gunicorn && yum -y clean all
RUN yum -y install epel-release && yum -y clean all
RUN yum -y --enablerepo=epel-testing install \
        datagrepper \
        python-psycopg2 \
        git && \
    yum -y clean all
COPY fedmsg.d/ /etc/fedmsg.d/
COPY static/ /usr/lib/python2.7/site-packages/datagrepper/static/
RUN echo "DATAGREPPER_DOC_PATH='/var/tmp/fedmsg_meta_umb/datagrepper-docs/'" >> /etc/datagrepper/datagrepper.cfg
# Build-time dependencies of fedmsg_meta_umb, only required if installing from git
RUN yum -y install gcc libffi-devel openssl-devel python-devel python-nose python-pip && \
    yum -y clean all
RUN pip install cloud-sptheme
RUN cd /var/tmp && \
    git clone https://github.com/release-engineering/fedmsg_meta_umb && \
    cd fedmsg_meta_umb && \
    git checkout 3f8f099 && \
    python setup.py install && \
    sphinx-build doc/ htmldocs/ && \
    mv htmldocs /usr/lib/python2.7/site-packages/datagrepper/umb
COPY send_umb_docs.py /var/tmp
RUN cat /var/tmp/send_umb_docs.py >> /usr/lib/python2.7/site-packages/datagrepper/app.py
USER 1001
