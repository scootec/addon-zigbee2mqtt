ARG BUILD_FROM=hassioaddons/base:3.1.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set ARG after FROM
ARG ZIGBEE2MQTT_VERSION=1.3.1

COPY rootfs /

WORKDIR /opt/zigbee2mqtt

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Download latest release latest release
RUN curl -sL "https://github.com/Koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" \
    -o "${ZIGBEE2MQTT_VERSION}.tar.gz" && \
    tar xzvf "${ZIGBEE2MQTT_VERSION}.tar.gz" --strip-components=1 && \
    rm "${ZIGBEE2MQTT_VERSION}.tar.gz"

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
    g++=8.3.0-r0 \
    gcc=8.3.0-r0 \
    libc-dev=0.7.1-r0 \
    linux-headers=4.18.13-r1 \
    make=4.2.1-r2 \
    py2-pip=18.1-r0 \
    python2-dev=2.7.15-r3 \
    \
    && apk add --no-cache \
    nodejs=10.15.3-r0 \
    npm=10.15.3-r0
# Delete default configuration file & symlink to persistant data
RUN rm -rf data && \
    ln -s /data /opt/zigbee2mqtt/data \
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
    io.hass.name="Zigbee2mqtt" \
    io.hass.description="Zigbee2mqtt add-on by Community Hass.io Add-ons" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Shane Scott <scoootec@example.com>" \
    org.label-schema.description="Zigbee2mqtt add-on by Community Hass.io Add-ons" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Zigbee2mqtt" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-zigbee2mqtt/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-zigbee2mqtt" \
    org.label-schema.vendor="Community Hass.io Addons"