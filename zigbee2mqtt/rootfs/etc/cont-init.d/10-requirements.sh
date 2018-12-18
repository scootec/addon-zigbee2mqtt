#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: zigbee2mqtt
# This files check if all user configuration requirements are met
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# Require permit join boulean
if ! hass.config.has_value 'permit_join'
then
    hass.die 'You need to set a permit join boulean!'
fi

# Require base topic
if ! hass.config.has_value 'mqtt_base_topic'
then
    hass.die 'You need to set a MQTT base topic!'
fi

# Require base topic
if ! hass.config.has_value 'mqtt_server'
then
    hass.die 'You need to set a MQTT Server!'
fi

# Require base topic
if ! hass.device_exists 'serial_port'
then
    hass.die 'No device detected at that serial port!'
fi

# Require username / password
if ! hass.config.has_value 'mqtt_user'
then
    hass.die 'You need to set a username!'
fi

if ! hass.config.has_value 'mqtt_pass'
then
    hass.die 'You need to set a password!'
fi