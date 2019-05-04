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

# Require rtscts
if ! bashio::config.has_value 'rtscts'; then
    bashio::exit.nok 'You need to set rtscts!'
fi

# Debug option
if bashio::config.true 'zigbee_shepherd_debug'; then
    bashio::log "Enabling zigbee shepard and zigbee2mqtt debug logging..."
    export DEBUG="*"
fi

# set config directory
CONFIG='/opt/zigbee2mqtt/data/configuration.yaml'

# Don't touch config if exists
# Pending upstream change (hopefully) to move device configuration to seperate yaml
if ! bashio::fs.file_exists $CONFIG; then
    # Create new config file
    touch "$CONFIG"

    # add configuration
    { 
    echo "homeassistant: $(bashio::config 'homeassistant')"; \
    echo "permit_join: $(bashio::config 'permit_join')"; \
    echo "mqtt:"; \
    echo "  base_topic: $(bashio::config 'mqtt_base_topic')"; \
    echo "  server: $(bashio::config 'mqtt_server')"; \
    echo "  user: $(bashio::config 'mqtt_user')"; \
    echo "  password: $(bashio::config 'mqtt_pass')"; \
    echo "serial:"; \
    echo "  port: $(bashio::config 'serial_port')"; \
    echo "advanced:"; \
    echo "  rtscts: $(bashio::config 'rtscts')"; \
    echo "devices: devices.yaml"; \
    echo "groups: groups.yaml"; \
    } >> "$CONFIG"
fi