ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:13.0.1
# https://github.com/hassio-addons/addon-base/releases
# Remember to update build file as well
# Waiting on next base version to fix musl 
FROM ${BUILD_FROM}

# Set Zigbee2MQTT Version. Needs to be after FROM
ARG ZIGBEE2MQTT_VERSION=1.29.2

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN apk add --no-cache --virtual .build-dependencies \
    g++ \
    gcc \
    git \
    linux-headers \
    make \
    python3-dev \
    eudev \
    npm \
    \
    && apk add --no-cache \
    nodejs

# Create work dir. Download latest release. Remove unnecessary directories.
RUN mkdir -p /opt/zigbee2mqtt \
    && cd /opt/zigbee2mqtt \
    && curl -sL "https://github.com/Koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" \
    -o "release.tar.gz" \
    && tar -xzvf "release.tar.gz" --strip-components=1 \
    # Install remaining dependencies
    && npm ci \
    --no-audit \
    --no-optional \
    --no-update-notifier \
    --unsafe-perm \
    # Serialport needs to be rebuilt https://github.com/Koenkk/zigbee2mqtt/pull/15400
    && npm rebuild --build-from-source \
    && npm run build \
    # Cleanup
    && npm prune --production \
    && npm cache clear --force \
    && apk del --purge .build-dependencies \
    && find . \
    -not -path './dist/*' \
    -not -path './node_modules/*' \
    -not -name 'index.js' \
    -not -name 'package.json' \
    -delete

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