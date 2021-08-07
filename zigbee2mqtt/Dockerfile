ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:10.0.0
ARG ZIGBEE2MQTT_VERSION=1.21.0

# Stage 1: Build
FROM ${BUILD_FROM} as builder

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN apk add --no-cache --virtual .build-dependencies \
    make \
    gcc \
    g++ \
    git \
    linux-headers \
    python3-dev \
    eudev \
    \
    && apk add --no-cache \
    nodejs \
    npm

# Create work dir. Download latest release.
RUN mkdir -p /opt/zigbee2mqtt \
    && cd /opt/zigbee2mqtt \
    && curl -sL "https://github.com/Koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" \
    -o "release.tar.gz" \
    && tar -xzvf "release.tar.gz" --strip-components=1 \
    && npm ci \
    --no-audit \
    --no-optional \
    --no-update-notifier \
    --unsafe-perm \
    && npm run build \
    && npm prune --production

# Stage 2: Production
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN mkdir -p /opt/zigbee2mqtt \
    && apk add --no-cache \
    nodejs \
    npm

# Copy from builder container
COPY --from=builder \
    /opt/zigbee2mqtt/dist \
    /opt/zigbee2mqtt/node_modules \
    /opt/zigbee2mqtt/index.js \
    /opt/zigbee2mqtt/package.json \
    # Destination Directory
    /opt/zigbee2mqtt/

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