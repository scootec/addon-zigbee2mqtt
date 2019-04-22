#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Zigbee2mqtt
# Sets up Zigbee2mqtt.
# ==============================================================================

# Symlinks data directory on first start. database.db only present after first start.
if ! bashio::fs.file_exists '/opt/zigbee2mqtt/data/database.db'; then
    bashio::log "Deleting /opt/zigbee2mqtt/data folder."
    rm -rf /opt/zigbee2mqtt/data \
    || bashio::exit.nok "Could not delete /opt/zigbee2mqtt/data folder."

    bashio::log "Symlinking /opt/zigbee2mqtt/data to persistant storage."
    ln -s /data /opt/zigbee2mqtt/data \
    || bashio::exit.nok "Could not symlink /opt/zigbee2mqtt/data to persistant storage."
fi

# Creates devices configuration files on first start.
if ! bashio::fs.file_exists '/opt/zigbee2mqtt/data/devices.yaml'; then
    bashio::log "Creating devices.yaml."
    touch /opt/zigbee2mqtt/data/devices.yaml \
        || bashio::exit.nok "Could not create devices.yaml."
fi

# Creates groups configuration files on first start.
if ! bashio::fs.file_exists '/opt/zigbee2mqtt/data/groups.yaml'; then
    bashio::log "Creating groups.yaml."
    touch /opt/zigbee2mqtt/data/groups.yaml \
        || bashio::exit.nok "Could not create groups.yaml."
fi