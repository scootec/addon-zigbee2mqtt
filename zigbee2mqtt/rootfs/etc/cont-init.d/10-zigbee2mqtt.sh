#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Zigbee2mqtt
# Sets up Zigbee2mqtt.
# ==============================================================================

# Creates configuration folder if it does not exist.
if ! bashio::fs.directory_exists '/share/zigbee2mqtt'; then
    bashio::log "Creating zigbee2mqtt folder in /share"
    mkdir /share/zigbee2mqtt \
        || bashio::exit.nok "Could not create /share/zigbee2mqtt."
fi

# Creates devices configuration files on first start.
if ! bashio::fs.file_exists '/share/zigbee2mqtt/devices.yaml'; then
    bashio::log "Creating devices.yaml."
    touch /share/zigbee2mqtt/devices.yaml \
        || bashio::exit.nok "Could not create devices.yaml."
fi

# Creates groups configuration files on first start.
if ! bashio::fs.file_exists '/share/zigbee2mqtt/groups.yaml'; then
    bashio::log "Creating groups.yaml."
    touch /share/zigbee2mqtt/groups.yaml \
        || bashio::exit.nok "Could not create groups.yaml."
fi