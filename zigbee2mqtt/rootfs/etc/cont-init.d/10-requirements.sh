#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: zigbee2mqtt
# This files check if all user configuration requirements are met
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# Require permit join boulean
# if ! hass.config.has_value 'permit_join'
# then
#     hass.die 'You need to set a permit join boulean!'
# fi

# Require base topic
if ! bashio::config.has_value 'mqtt_base_topic'
then
    bashio::die 'You need to set a MQTT base topic!'
fi

# Require mqtt server
if ! bashio::config.has_value 'mqtt_server'
then
    bashio::die 'You need to set a MQTT Server!'
fi

# Require base topic
# if ! bashio::device_exists 'serial_port'
# then
#     bashio::die 'No device detected at that serial port!'
# fi

# Require username / password
if ! bashio::config.has_value 'mqtt_user'
then
    bashio::die 'You need to set a username!'
fi

if ! bashio::config.has_value 'mqtt_pass'
then
    bashio::die 'You need to set a password!'
fi