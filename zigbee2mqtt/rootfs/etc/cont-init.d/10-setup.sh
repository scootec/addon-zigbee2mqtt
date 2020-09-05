#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Zigbee2MQTT
# Sets up Zigbee2MQTT.
# ==============================================================================

# Creates configuration folder if it does not exist.
if ! bashio::fs.directory_exists '/share/addon-zigbee2mqtt'; then
    bashio::log "Creating zigbee2mqtt folder in /share."
    mkdir /share/addon-zigbee2mqtt \
        || bashio::exit.nok "Could not create /share/addon-zigbee2mqtt."
fi

# Creates configuration.yaml on first start.
if ! bashio::fs.file_exists '/share/addon-zigbee2mqtt/configuration.yaml'; then
    bashio::log "Creating configuration.yaml."
    touch /share/addon-zigbee2mqtt/configuration.yaml \
        || bashio::exit.nok "Could not create configuration.yaml."
fi

# Creates devices configuration files on first start.
if ! bashio::fs.file_exists '/share/addon-zigbee2mqtt/devices.yaml'; then
    bashio::log "Creating devices.yaml."
    touch /share/addon-zigbee2mqtt/devices.yaml \
        || bashio::exit.nok "Could not create devices.yaml."
fi

# Creates groups configuration files on first start.
if ! bashio::fs.file_exists '/share/addon-zigbee2mqtt/groups.yaml'; then
    bashio::log "Creating groups.yaml."
    touch /share/addon-zigbee2mqtt/groups.yaml \
        || bashio::exit.nok "Could not create groups.yaml."
fi

# Check for empty config file
if [ ! -s '/share/addon-zigbee2mqtt/configuration.yaml' ]; then
    bashio::exit.nok "Your configuration.yaml is empty! Please add a configuration and restart the addon."
fi

# Links /opt/zigbee2mqtt/data to /share/addon-zigbee2mqtt
if ! bashio::fs.directory_exists '/opt/zigbee2mqtt/data'; then
    bashio::log "Linking /opt/zigbee2mqtt/data to /share/addon-zigbee2mqtt."
    ln -s /share/addon-zigbee2mqtt /opt/zigbee2mqtt/data \
        || bashio::exit.nok "Could not create symbolic link."
fi