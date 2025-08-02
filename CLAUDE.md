# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Home Assistant add-on that packages Zigbee2MQTT as a containerized service. It bridges Zigbee devices to MQTT, allowing integration with Home Assistant and other smart home systems.

## Architecture

### Key Components
- **Docker Container**: Multi-stage build using Debian base image
- **Zigbee2MQTT**: Downloaded and built from official releases (currently v2.3.0)
- **Home Assistant Integration**: Uses Home Assistant's add-on framework with ingress support
- **Configuration Management**: Auto-generates default config using HA's MQTT service

### File Structure
- `zigbee2mqtt/Dockerfile`: Multi-stage Docker build with Node.js 20 LTS
- `zigbee2mqtt/config.json`: Add-on configuration and metadata
- `zigbee2mqtt/build.yaml`: Architecture-specific build targets
- `zigbee2mqtt/rootfs/`: Container filesystem overlay
  - `etc/cont-init.d/zigbee2mqtt.sh`: Initialization script for config setup
  - `etc/services.d/zigbee2mqtt/run`: Service execution script

## Development Commands

### Docker Build
```bash
# Build for specific architecture (from zigbee2mqtt directory)
docker build --build-arg BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.8.3 .
```

### Configuration Management
- Add-on creates `/config/zigbee2mqtt/configuration.yaml` on first run
- Default config auto-configured using Home Assistant's MQTT service
- Configuration must be reviewed and serial port configured before operation

### Version Updates
1. Update `ZIGBEE2MQTT_VERSION` in `Dockerfile` (line 9)
2. Update version in `config.json`
3. Update base image versions in both `Dockerfile` and `build.yaml` if needed

## Key Configuration Files

### zigbee2mqtt/config.json
- Defines add-on metadata, dependencies, and schema
- Requires Home Assistant 2024.9.0+
- Maps config directory and requires MQTT service
- Single option: `zigbee_herdsman_debug` for enhanced Zigbee debugging

### zigbee2mqtt/Dockerfile
- Multi-stage build: builder stage compiles, runtime stage runs
- Uses pnpm for dependency management
- Includes health check on port 8099
- Runs as root user (required for hardware access)

## Runtime Behavior

### Initialization (cont-init.d/zigbee2mqtt.sh)
1. Creates `/config/zigbee2mqtt` directory if missing
2. Creates default `configuration.yaml` if empty
3. Auto-configures MQTT connection using HA service discovery
4. Exits with configuration instructions on first run

### Service Execution (services.d/zigbee2mqtt/run)
- Sets `ZIGBEE2MQTT_DATA="/config/zigbee2mqtt"`
- Enables Zigbee Herdsman debug if configured
- Validates configuration file exists
- Runs Zigbee2MQTT as root from `/opt/zigbee2mqtt`

## Integration Points

### Home Assistant
- Supports ingress for web UI access
- Auto-discovery via MQTT
- Requires MQTT service to be available
- Panel icon: `mdi:zigbee`

### Hardware Requirements
- UART access for Zigbee coordinator
- Serial port configuration required in `configuration.yaml`
- Supports multiple architectures: aarch64, amd64, armhf, i386

## Linting and Code Quality

Uses YAML linting with configuration in `.yamllint`:
```bash
yamllint .
```

Markdown linting configured in `.markdownlint.json`.