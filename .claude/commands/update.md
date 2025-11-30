# Update Command

This command updates the Zigbee2MQTT Home Assistant add-on to the latest versions of its dependencies.

## Process

### 1. Check Zigbee2MQTT Latest Release

- Fetch the latest release from https://github.com/Koenkk/zigbee2mqtt/releases/latest
- Extract the version number (remove 'v' prefix if present)
- Compare with current version in `zigbee2mqtt/Dockerfile` (line 9: `ARG ZIGBEE2MQTT_VERSION=X.X.X`)

### 2. Check Base Add-on Latest Release

- Fetch the latest release from https://github.com/hassio-addons/addon-debian-base/releases/latest
- Extract the version number
- Compare with current version in:
  - `zigbee2mqtt/Dockerfile` (lines 4 and 44: `ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:X.X.X`)
  - `zigbee2mqtt/build.yaml` (lines 2-3: `ghcr.io/hassio-addons/debian-base:X.X.X`)

### 3. Check Node.js LTS Version

- Fetch the latest LTS version from https://nodejs.org/dist/index.json
- Find the latest entry where `lts` is not `false`
- Extract major version number
- Compare with current version in `zigbee2mqtt/Dockerfile` (lines 15 and 51: `setup_XX.x`)

### 4. Check Home Assistant Version Requirements

- If Zigbee2MQTT version changed, fetch the release notes from the latest release
- Look for any mentions of Home Assistant version requirements
- If found, compare with current minimum version in `zigbee2mqtt/config.json` (line 14: `"homeassistant": "YYYY.M.0"`)
- Update if the new requirement is higher

### 5. Update Files

If any versions need updating:

#### Update zigbee2mqtt/Dockerfile:
- Line 9: `ARG ZIGBEE2MQTT_VERSION=NEW_VERSION`
- Lines 4 and 44: `ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:NEW_BASE_VERSION`
- Lines 15 and 51: `https://deb.nodesource.com/setup_NEW_NODEJS.x`

#### Update zigbee2mqtt/build.yaml:
- Lines 2-3: Update base image versions to match Dockerfile

#### Update zigbee2mqtt/config.json:
- Line 14: Update `"homeassistant"` if requirements changed
- Line 3: Update `"version"` using format: `"${ZIGBEE2MQTT_VERSION}-${ADDON_VERSION}"`

#### Update zigbee2mqtt/CHANGELOG.md:
- Add a new version entry with the version number and date
- List all changes in the appropriate categories (Added, Changed, Fixed, etc.)
- Update the comparison links at the bottom of the file
- Follow the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format

### 6. Calculate New Add-on Version

The add-on version format is: `${ZIGBEE2MQTT_VERSION}-${ADDON_VERSION}`

- If Zigbee2MQTT version changed: Reset addon version to 1 (e.g., `"2.4.0-1"`)
- If only other dependencies changed: Increment addon version (e.g., `"2.3.0-2"` → `"2.3.0-3"`)

### 7. Summary

Provide a summary of all changes made:
- Zigbee2MQTT version: OLD → NEW (if changed)
- Base add-on version: OLD → NEW (if changed) 
- Node.js version: OLD → NEW (if changed)
- Home Assistant minimum: OLD → NEW (if changed)
- Add-on version: OLD → NEW

### 8. Next Steps

Remind the user to:
1. Review changes with `git diff`
2. Test the build locally
3. Commit changes
4. Create a release