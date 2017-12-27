FROM webdevops/apache:ubuntu-16.04

MAINTAINER Eric Pfeiffer <computerfr33k@users.noreply.github.com>

ARG PHP_UPSTREAM_CONTAINER=php-fpm
ARG PHP_UPSTREAM_PORT=9000
ARG PHP_UPSTREAM_TIMEOUT=60
ARG WEB_DOC_ROOT=/var/www/
ARG PUID=1000

USER root
ENV PUID ${PUID}
RUN usermod -u ${PUID} www-data

ENV WEB_PHP_SOCKET=${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}

ENV WEB_DOCUMENT_ROOT=${WEB_DOC_ROOT}
ENV WEB_PHP_TIMEOUT=${PHP_UPSTREAM_TIMEOUT}

EXPOSE 80 443 4040

WORKDIR /var/www/

COPY vhost.conf /etc/apache2/sites-enabled/vhost.conf

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]

CMD ["supervisord"]

#####################################
# ngrok:
#####################################
USER root

ARG INSTALL_NGROK=false
ENV INSTALL_NGROK ${INSTALL_NGROK}

RUN if [ ${INSTALL_NGROK} = true ]; then \
    apt-get update \
    && apt-get -y install zip wget unzip \
    && wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
    && unzip ngrok-stable-linux-amd64.zip \
    && mv ngrok /usr/local/bin/ \
    && rm -f ngrok-stable-linux-amd64.zip \
    && ngrok authtoken ${NGROK_AUTH_TOKEN} \
    && ngrok http 80 > /dev/null & \
;fi