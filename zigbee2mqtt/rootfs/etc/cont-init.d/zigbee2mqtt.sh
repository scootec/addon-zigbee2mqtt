#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Zigbee2MQTT
# Sets up Zigbee2MQTT.
# ==============================================================================

# Creates configuration folder if it does not exist.
if ! bashio::fs.directory_exists '/config/zigbee2mqtt'; then
    bashio::log.info "Creating zigbee2mqtt folder in /config..."
    mkdir /config/zigbee2mqtt \
        || bashio::exit.nok "Could not create /config/zigbee2mqtt."
fi

# Creates configuration.yaml on first start.
if ! bashio::fs.file_exists '/config/zigbee2mqtt/configuration.yaml'; then
    bashio::log.info "Creating configuration.yaml..."
    touch /config/zigbee2mqtt/configuration.yaml \
        || bashio::exit.nok "Could not create configuration.yaml."
fi

# Check for empty config file and creates default config
if [ ! -s '/config/zigbee2mqtt/configuration.yaml' ]; then
    if ! bashio::services.available "mqtt"; then
        bashio::exit.nok "Home Assistant MQTT service is not available. Please add a configuration.yaml to /config/zigbee2mqtt and restart the addon."
    fi

    bashio::log.info "Creating default configuration using Home Assistant MQTT broker..."
    HOST=$(bashio::services "mqtt" "host")
    PORT=$(bashio::services "mqtt" "port")
    USERNAME=$(bashio::services "mqtt" "username")
    PASSWORD=$(bashio::services "mqtt" "password")
    {
        echo "homeassistant: true"
        echo "permit_join: false"
        echo "mqtt:"
        echo "  base_topic: zigbee2mqtt"
        echo "  server: mqtt://${HOST}:${PORT}"
        echo "  user: ${USERNAME}"
        echo "  password: ${PASSWORD}"
        echo "serial:"
        echo "  port: null"
        echo "frontend:"
        echo "  port: 8099"
        echo "experimental:"
        echo "  new_api: true"
        echo "advanced:"
        echo "  log_output:"
        echo "    - console"
        echo "  network_key: GENERATE"
    } > /config/zigbee2mqtt/configuration.yaml \
        || bashio::exit.nok "Default configuration failed! Please add a configuration.yaml to /config/zigbee2mqtt then restart the addon."
    bashio::exit.nok "Default configuration created. Please review the configuration.yaml in /config/zigbee2mqtt then restart the addon."
fi