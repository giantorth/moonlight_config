#!/bin/bash

# update_cyberpunk_resolution.sh
# Updates Cyberpunk 2077 resolution in UserSettings.json to match the PRIMARY display

# 1. Get current resolution of the primary display using xrandr
resolution=$(xrandr | awk '/ connected primary / {print $4}' | cut -d+ -f1)

if [ -z "$resolution" ]; then
    echo "❌ Could not determine primary display resolution with xrandr."
    exit 1
fi

echo "✅ Detected primary display resolution: $resolution"

# 2. Define path to UserSettings.json
jsonFilePath="$HOME/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/AppData/Local/CD Projekt Red/Cyberpunk 2077/UserSettings.json"
backupFilePath="${jsonFilePath}.bak"

# 3. Backup if it doesn't exist
if [ ! -f "$backupFilePath" ]; then
    cp "$jsonFilePath" "$backupFilePath"
    echo "📦 Backed up UserSettings.json to UserSettings.json.bak"
else
    echo "ℹ️  Backup already exists. Skipping."
fi

# 4. Modify the JSON using jq
tmpFile=$(mktemp)

jq --arg res "$resolution" '
  .data |= map(
    if .group_name == "/video/display" then
      .options |= map(
        if .name == "Resolution" then
          .value = $res
        else
          .
        end
      )
    else
      .
    end
  )
' "$jsonFilePath" > "$tmpFile"

# 5. Save changes back to the file
mv "$tmpFile" "$jsonFilePath"
echo "✅ Updated resolution in UserSettings.json to $resolution"
exec "$@"
