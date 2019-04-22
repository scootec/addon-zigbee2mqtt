#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Zigbee2mqtt
# Sets user settings.
# ==============================================================================

# Require homeassistant
if ! bashio::config.has_value 'homeassistant'; then
    bashio::exit.nok 'You need to homeassistant true or false!'
fi

# Require permit_join
if ! bashio::config.has_value 'permit_join'; then
    bashio::exit.nok 'You need to permit_join true or false!'
fi

# Require base topic
if ! bashio::config.has_value 'mqtt_base_topic'; then
    bashio::exit.nok 'You need to set a MQTT base topic!'
fi

# Require mqtt server
if ! bashio::config.has_value 'mqtt_server'; then
    bashio::exit.nok 'You need to set a MQTT Server!'
fi

# Require mqtt username
if ! bashio::config.has_value 'mqtt_user'; then
    bashio::exit.nok 'You need to set a username!'
fi

# Require mqtt password
if ! bashio::config.has_value 'mqtt_pass'; then
    bashio::exit.nok 'You need to set a password!'
fi

# Require serial port
if ! bashio::config.has_value 'serial_port'; then
    bashio::exit.nok 'You need to set a serial port!'
fi

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
    echo "  server: $(bashio::config.get 'mqtt_server')"; \
    echo "  user: $(bashio::config.get 'mqtt_user')"; \
    echo "  password: $(bashio::config.get 'mqtt_pass')"; \
    echo "serial:"; \
    echo "  port: $(bashio::config.get 'serial_port')"; \
    echo "devices: devices.yaml"; \
    echo "groups: groups.yaml"; \
    } >> "$CONFIG"
fi