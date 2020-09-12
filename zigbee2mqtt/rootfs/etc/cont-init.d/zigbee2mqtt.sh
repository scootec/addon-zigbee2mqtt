#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Zigbee2MQTT
# Sets up Zigbee2MQTT.
# ==============================================================================

# Creates configuration folder if it does not exist.
if ! bashio::fs.directory_exists '/config/zigbee2mqtt'; then
    bashio::log.info "Creating zigbee2mqtt folder in /config."
    mkdir /config/zigbee2mqtt \
        || bashio::exit.nok "Could not create /config/zigbee2mqtt."
fi

# Creates configuration.yaml on first start.
if ! bashio::fs.file_exists '/config/zigbee2mqtt/configuration.yaml'; then
    bashio::log.info "Creating configuration.yaml..."
    touch /config/zigbee2mqtt/configuration.yaml \
        || bashio::exit.nok "Could not create configuration.yaml."
fi

# Check for empty config file
if [ ! -s '/config/zigbee2mqtt/configuration.yaml' ]; then
    if ! bashio::services.available "mqtt"; then
        bashio::exit.nok "Home Assistant MQTT service is not available. Please add a configuration.yaml to /config/zigbee2mqtt and restart the addon."
    fi
    bashio::log.info "Creating default configuration..."
    host=$(bashio::services "mqtt" "host")
    port=$(bashio::services "mqtt" "port")
    username=$(bashio::services "mqtt" "username")
    password=$(bashio::services "mqtt" "password")
    {
        echo "homeassistant: true"
        echo "permit_join: false"
        echo "mqtt:"
        echo "  base_topic: zigbee2mqtt"
        echo "  server: mqtt://$host:$port"
        echo "  user: $username"
        echo "  password: $password"
        echo "serial:"
        echo "  port: null"
        echo "advanced:"
        echo "  log_output:"
        echo "    - console"
        echo "  network_key: GENERATE"
        echo "devices: devices.yaml"
        echo "groups: groups.yaml"
    } > /config/zigbee2mqtt/configuration.yaml \
        || bashio::exit.nok "Default configuration failed! Please add a configuration.yaml to /config/zigbee2mqtt and restart the addon."
fi

# Creates devices configuration files on first start.
if ! bashio::fs.file_exists '/config/zigbee2mqtt/devices.yaml'; then
    bashio::log.info "Creating devices.yaml."
    touch /config/zigbee2mqtt/devices.yaml \
        || bashio::exit.nok "Could not create devices.yaml."
fi

# Creates groups configuration files on first start.
if ! bashio::fs.file_exists '/config/zigbee2mqtt/groups.yaml'; then
    bashio::log.info "Creating groups.yaml."
    touch /config/zigbee2mqtt/groups.yaml \
        || bashio::exit.nok "Could not create groups.yaml."
fi