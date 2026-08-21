#!/bin/sh
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

echo "Updating media.js with all media files..."

# Write media.js header
cat << 'EOF' > media.js
const mediaFiles = [
EOF

# Find all image and video files in media directory (case-insensitive)
if [ -d "media" ]; then
    find -L media -maxdepth 1 -type f \( \
        -name "*.jpg" -o -name "*.JPG" -o \
        -name "*.jpeg" -o -name "*.JPEG" -o \
        -name "*.png" -o -name "*.PNG" -o \
        -name "*.gif" -o -name "*.GIF" -o \
        -name "*.mp4" -o -name "*.MP4" -o \
        -name "*.webm" -o -name "*.WEBM" -o \
        -name "*.webp" -o -name "*.WEBP" \
    \) 2>/dev/null | sort | while read -r filepath; do
        filename="$(basename "$filepath")"
        echo "    \"$filename\"," >> media.js
    done
fi

cat << 'EOF' >> media.js
];
EOF

echo "Successfully updated media.js!"
