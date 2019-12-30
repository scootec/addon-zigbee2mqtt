ARG BUILD_FROM=hassioaddons/base:6.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ENV ZIGBEE2MQTT_VERSION=1.8.0

COPY rootfs /

WORKDIR /opt/zigbee2mqtt

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN apk add --no-cache --virtual .build-dependencies \
    make \
    gcc \
    g++ \
    python \
    linux-headers \
    udev \
    git \
    \
    && apk add --no-cache \
    nodejs \
    npm

# # Download latest release. Remove unnecessary directories. Symlink to data dir.
RUN curl -sL "https://github.com/Koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" \
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