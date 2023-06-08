ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

RUN curl -J -L -o /tmp/bashio.tar.gz \
        "https://github.com/hassio-addons/bashio/archive/v0.7.1.tar.gz" \
    && mkdir /tmp/bashio \
    && tar zxvf \
        /tmp/bashio.tar.gz \
        --strip 1 -C /tmp/bashio \
    \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -fr /tmp/* 

# use /share/sabnzbd/config instead of /config for hass.io environment
RUN sed -i "s|/config|/share/sabnzbd/config|g" /etc/s6-overlay/s6-rc.d/init-sabnzbd-config/run \
    && sed -i "s|/config|/share/sabnzbd/config|g" /etc/s6-overlay/s6-rc.d/svc-sabnzbd/run

# copy local files
COPY root/ /
