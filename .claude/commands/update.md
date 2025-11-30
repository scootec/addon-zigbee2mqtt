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

**Note**: This project does not use a CHANGELOG.md file. All version changes are documented using GitHub Releases following the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.

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

### 8. Commit and Release

After making all updates:

1. Show the changes to the user with `git diff`
2. Ask the user to confirm if the changes look good to commit
3. If confirmed:
   - Commit the changes with message: `"Update to version ${NEW_VERSION}"`
   - Add detailed commit body listing all component updates
   - Push to the remote repository
   - Create a GitHub release using `gh release create` with:
     - Tag: `v${NEW_VERSION}`
     - Title: `v${NEW_VERSION}`
     - Release notes formatted following [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) standard:
       ```
       ## Changed
       - Updated Zigbee2MQTT to version X.X.X (if changed)
       - Updated base image to X.X.X (if changed)
       - Updated Node.js to version XX (if changed)
       - Updated Home Assistant minimum to YYYY.M.0 (if changed)
       ```
4. If user declines, remind them they can commit and release manually later