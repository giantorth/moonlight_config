#!/bin/bash

# disco.sh
# Updates Disco Elysium resolution in Settings.json to match the PRIMARY display

# 1. Get current resolution of the primary display using xrandr
resolution=$(xrandr | awk '/ connected primary / {print $4}' | cut -d+ -f1)

if [ -z "$resolution" ]; then
    echo "Could not determine primary display resolution with xrandr."
    exit 1
fi

echo "Detected primary display resolution: $resolution"

# 2. Split resolution into width and height
width=$(echo "$resolution" | cut -d'x' -f1)
height=$(echo "$resolution" | cut -d'x' -f2)

# 3. Define path to Settings.json
jsonFilePath="$HOME/.local/share/Steam/steamapps/compatdata/632470/pfx/drive_c/users/steamuser/AppData/LocalLow/ZAUM Studio/Disco Elysium/Settings/Settings.json"
backupFilePath="${jsonFilePath}.bak"

# 4. Backup 
if [ ! -f "$backupFilePath" ]; then
    cp "$jsonFilePath" "$backupFilePath"
    echo "Backed up Settings.json to Settings.json.bak"
else
    echo "Backup already exists. Skipping."
fi

# 5. Modify the JSON using jq
tmpFile=$(mktemp)

jq --argjson w "$width" --argjson h "$height" '
  .GRAPHICS.resolutionWidth.intValue = $w
  | .GRAPHICS.resolutionHeight.intValue = $h
  | .
' "$jsonFilePath" | python3 -m json.tool --indent 4 > "$tmpFile"

# 6. Save changes back to the file
mv "$tmpFile" "$jsonFilePath"
echo "Updated resolution in Settings.json to ${width}x${height}"
exec "$@"
