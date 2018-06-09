FROM library/ubuntu:16.04

# Superset version
ARG SUPERSET_VERSION=0.25.2

# Configure environment
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONPATH=/home/superset/.superset:$PYTHONPATH \
    SUPERSET_VERSION=${SUPERSET_VERSION}

# Create superset user & install dependencies
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        libldap2-dev \
        libpq-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        libldap2-dev \
        openjdk-8-jdk \
        python3-dev \
        python3-pip && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/* && \
    pip3 install --no-cache-dir \
        contextlib2==0.5.5 \
        flask==0.12.2 \
        flask-cors==3.0.3 \
        flask-mail==0.9.1 \
        flask-oauth==0.12 \
        flask_oauthlib==0.9.3 \
        psycopg2==2.7.1 \
        pyathenajdbc==1.2.0 \
        pyhive==0.5.2 \
        redis==2.10.5 \
        sqlalchemy-utils==0.32.21 \
        superset==${SUPERSET_VERSION}

# Configure Filesystem
COPY superset_config.py /home/superset/.superset/superset_config.py
COPY init.sh /usr/local/bin/init.sh
VOLUME /home/superset
WORKDIR /home/superset

# Deploy application
EXPOSE 8088
ENTRYPOINT ["superset"]
CMD ["runserver"]
