# Build stage
# https://github.com/hassio-addons/addon-debian-base
# Remember to update build file as well
ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.8.3
FROM ${BUILD_FROM} AS builder

# Set Zigbee2MQTT Version. Needs to be after FROM
# https://github.com/Koenkk/zigbee2mqtt/releases
ARG ZIGBEE2MQTT_VERSION=2.3.0

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup Node.js 20 (LTS) and build dependencies
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    nodejs \
    make \
    g++ \
    gcc \
    python3-dev \
    ca-certificates \
    curl \
    && npm install -g pnpm \
    && rm -rf /var/lib/apt/lists/*

# Create work dir and download Zigbee2MQTT
WORKDIR /opt/zigbee2mqtt
RUN curl -sL "https://github.com/Koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" \
    -o "release.tar.gz" \
    && tar -xzf "release.tar.gz" --strip-components=1 \
    && rm release.tar.gz

# Install dependencies and build
RUN pnpm install --frozen-lockfile --no-optional \
    && pnpm run build \
    && pnpm prune --production \
    && pnpm store prune

# Runtime stage
# https://github.com/hassio-addons/addon-debian-base
# Remember to update build file as well
ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.8.3
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install only runtime dependencies
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    nodejs \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/* \
    && rm -rf /tmp/*

# Copy built application from builder stage
COPY --from=builder /opt/zigbee2mqtt /opt/zigbee2mqtt

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8099/api/info || exit 1

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