ARG BUILD_FROM=hassioaddons/base:8.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ENV ZIGBEE2MQTT_VERSION=1.14.4

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN apk add --no-cache --virtual .build-dependencies \
    curl=7.72.0-r0 \
    g++=10.2.0-r5 \
    gcc=10.2.0-r5 \
    git=2.28.0-r1 \
    linux-headers=5.7.8-r0 \
    make=4.3-r0 \
    python2=2.7.18-r0 \
    eudev=3.2.9-r3 \
    \
    && apk add --no-cache \
    nodejs=12.18.3-r0 \
    npm=12.18.3-r0

# Create work dir. Download latest release. Remove unnecessary directories.
RUN mkdir -p /opt/zigbee2mqtt \
    && cd /opt/zigbee2mqtt \
    && curl -sL "https://github.com/Koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" \
    -o "release.tar.gz" \
    && tar -xzvf "release.tar.gz" --strip-components=1 \
    && find . \
    -not -path './lib/*' \
    -not -name 'index.js' \
    -not -name 'package.json' \
    -not -name 'npm-shrinkwrap.json' \
    -delete \
    && npm install \
    --no-audit \
    --no-optional \
    --no-update-notifier \
    --only=production \
    --unsafe-perm \
    \
    && npm cache clear --force \
    \
    && apk del --purge .build-dependencies

# Copy /etc
COPY rootfs /

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Zigbee2MQTT" \
    io.hass.description="" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Shane Scott" \
    org.opencontainers.image.title="Zigbee2MQTT" \
    org.opencontainers.image.description="Zigbee to MQTT bridge." \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Shane Scott" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/scootec/addon-zigbee2mqtt" \
    org.opencontainers.image.source="https://github.com/scootec/addon-zigbee2mqtt" \
    org.opencontainers.image.documentation="https://github.com/scootec/addon-zigbee2mqtt" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}