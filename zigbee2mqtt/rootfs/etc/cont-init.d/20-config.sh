#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: zigbee2mqtt
# Configures the zigbee2mqtt configuration.yaml
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# set config directory
CONFIG='/opt/zigbee2mqtt/data/configuration.yaml'

# # Remove existing config file
# if hass.file_exists $CONFIG; then
#     rm $CONFIG
# fi

# # Create new config file
# touch "$CONFIG"

# # add configuration
# { 
#   echo "homeassistant: $(hass.config.get 'homeassistant')"; \
#   echo "permit_join: $(hass.config.get 'permit_join')"; \
#   echo "mqtt:"; \
#   echo "  base_topic: $(hass.config.get 'mqtt_base_topic')"; \
#   echo "  server: $(hass.config.get 'mqtt_server')"; \
#   echo "  user: $(hass.config.get 'mqtt_user')"; \
#   echo "  password: $(hass.config.get 'mqtt_pass')"; \
#   echo "serial:"; \
#   echo "  port: $(hass.config.get 'serial_port')"; \
#   echo "  disable_led: $(hass.config.get 'disable_led')"; \
#   echo "advanced:"; \
#   echo "  cache_state: $(hass.config.get 'cache_state')"; \
#   echo "  log_level: $(hass.config.get 'log_level')"; \
# } >> "$CONFIG"

# Don't touch config if exists
# Pending upstream change (hopefully) to move device configuration to seperate yaml
if ! hass.file_exists $CONFIG; then
    # Create new config file
    touch "$CONFIG"

    # add configuration
    { 
    echo "homeassistant: $(hass.config.get 'homeassistant')"; \
    echo "permit_join: $(hass.config.get 'permit_join')"; \
    echo "mqtt:"; \
    echo "  base_topic: $(hass.config.get 'mqtt_base_topic')"; \
    echo "  server: $(hass.config.get 'mqtt_server')"; \
    echo "  user: $(hass.config.get 'mqtt_user')"; \
    echo "  password: $(hass.config.get 'mqtt_pass')"; \
    echo "serial:"; \
    echo "  port: $(hass.config.get 'serial_port')"; \
    echo "  disable_led: $(hass.config.get 'disable_led')"; \
    echo "advanced:"; \
    echo "  cache_state: $(hass.config.get 'cache_state')"; \
    echo "  log_level: $(hass.config.get 'log_level')"; \
    } >> "$CONFIG"
fi