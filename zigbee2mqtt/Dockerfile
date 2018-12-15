ARG BUILD_FROM=hassioaddons/base:2.3.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set ARG after FROM
ARG ZIGBEE2MQTT_VERSION=0.2.0

COPY rootfs /

WORKDIR /opt/zigbee2mqtt

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Grab latest release
RUN curl -sL "https://github.com/Koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" \
    -o "${ZIGBEE2MQTT_VERSION}.tar.gz" && \
    tar xzvf "${ZIGBEE2MQTT_VERSION}.tar.gz" --strip-components=1 && \
    rm "${ZIGBEE2MQTT_VERSION}.tar.gz"
    
# Delete default configuration file & symlink to persistant data
RUN rm -rf data && \
    ln -s /data /opt/zigbee2mqtt/data

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
        g++=6.4.0-r9 \
        gcc=6.4.0-r9 \
        libc-dev=0.7.1-r0 \
        linux-headers=4.4.6-r2 \
        make=4.2.1-r2 \
        py2-pip=10.0.1-r0 \
        python2-dev=2.7.15-r1 \
        python2=2.7.15-r1 \
    \
    && apk add --no-cache \
        git=2.18.1-r0 \
        nodejs=8.14.0-r0 \
        npm=8.14.0-r0 \
    \
    && npm install \
        --no-optional \
        --only=production \
    \
    && npm cache clear --force \
    \
    && apk del --purge --force-broken-world .build-dependencies

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Example" \
    io.hass.description="Example add-on by Community Hass.io Add-ons" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Example add-on by Community Hass.io Add-ons" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Example" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-example/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-example" \
    org.label-schema.vendor="Community Hass.io Addons"
