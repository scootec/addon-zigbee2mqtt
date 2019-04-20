#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: zigbee2mqtt
# Configures the zigbee2mqtt configuration.yaml
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# set config directory
CONFIG='/opt/zigbee2mqtt/data/configuration.yaml'

# Don't touch config if exists
# Pending upstream change (hopefully) to move device configuration to seperate yaml
if ! bashio::file_exists $CONFIG; then
    # Create new config file
    touch "$CONFIG"

    # add configuration
    { 
    echo "homeassistant: $(bashio::config.get 'homeassistant')"; \
    echo "permit_join: $(bashio::config.get 'permit_join')"; \
    echo "mqtt:"; \
    echo "  base_topic: $(bashio::config.get 'mqtt_base_topic')"; \
    echo "  server: $(bashio::config.get 'mqtt_server')"; \
    echo "  user: $(bashio::config.get 'mqtt_user')"; \
    echo "  password: $(bashio::config.get 'mqtt_pass')"; \
    echo "serial:"; \
    echo "  port: $(bashio::config.get 'serial_port')"; \
    echo "  disable_led: $(bashio::config.get 'disable_led')"; \
    echo "advanced:"; \
    echo "  cache_state: $(bashio::config.get 'cache_state')"; \
    echo "  log_level: $(bashio::config.get 'log_level')"; \
    } >> "$CONFIG"
fi