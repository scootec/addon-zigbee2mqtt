#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Zigbee2mqtt
# Sets up Zigbee2mqtt.
# ==============================================================================

# Creates configuration folder if it does not exist.
if ! bashio::fs.directory_exists '/config/zigbee2mqtt'; then
    bashio::log "Creating zigbee2mqtt folder in /config."
    mkdir /config/zigbee2mqtt \
        || bashio::exit.nok "Could not create /config/zigbee2mqtt."
fi

# Creates configuration.yaml on first start.
if ! bashio::fs.file_exists '/config/zigbee2mqtt/configuration.yaml'; then
    bashio::log "Creating configuration.yaml."
    touch /config/zigbee2mqtt/configuration.yaml \
        || bashio::exit.nok "Could not create configuration.yaml."
fi

# Creates devices configuration files on first start.
if ! bashio::fs.file_exists '/config/zigbee2mqtt/devices.yaml'; then
    bashio::log "Creating devices.yaml."
    touch /config/zigbee2mqtt/devices.yaml \
        || bashio::exit.nok "Could not create devices.yaml."
fi

# Creates groups configuration files on first start.
if ! bashio::fs.file_exists '/config/zigbee2mqtt/groups.yaml'; then
    bashio::log "Creating groups.yaml."
    touch /config/zigbee2mqtt/groups.yaml \
        || bashio::exit.nok "Could not create groups.yaml."
fi

# Check for empty config file
if [ -s '/config/zigbee2mqtt/configuration.yaml']; then
    bashio::exit.nok "Your configuration.yaml is empty! Please add a configuration and restart the addon."
fi

# Links /opt/zigbee2mqtt/data to /config/zigbee2mqtt
if ! bashio::fs.directory_exists '/opt/zigbee2mqtt/data'; then
    bashio::log "Linking /opt/zigbee2mqtt/data to /config/zigbee2mqtt."
    ln -s /config/zigbee2mqtt /opt/zigbee2mqtt/data \
        || bashio::exit.nok "Could not create symbolic link."
fi