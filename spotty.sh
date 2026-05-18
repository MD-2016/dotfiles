#!/bin/bash

# User-specific temporary location for album cover image
COVER_DIR="$HOME/.spotify_covers"
mkdir -p "$COVER_DIR"  # Create the directory if it doesn't exist
TMP="/tmp/spotify_cover.jpg"

# Fastfetch JSON config path
FASTFETCH_CONFIG="$HOME/.config/fastfetch/config.jsonc"

# Function to decode URL encoding (handle %20 as spaces etc.)
decode_url() {
    printf '%b' "${1//%/\\x}"
}

# Function to download the album cover
download_cover() {
    local URL="$1"
    if [[ $URL == file://* ]]; then
        # Handle local file:// URIs
        FILE_PATH=$(decode_url "${URL#file://}")

        if [[ -f "$FILE_PATH" ]]; then
            cp "$FILE_PATH" "$TMP"
        else
            echo "File not found: $FILE_PATH"
            return 1
        fi
    else
        # Handle http(s) URIs
        curl -sL "$URL" -o "$TMP" || { echo "Failed to download: $URL"; return 1; }
    fi
}

# Function to update the current cover image and Fastfetch config
update_cover() {
    # Get album art URL from playerctl
    URL=$(playerctl metadata mpris:artUrl 2>/dev/null)

    # Exit if nothing is playing
    if [ -z "$URL" ]; then
        echo "No song is currently playing."
        return 1
    fi

    # Download the new cover image
    if ! download_cover "$URL"; then
        return 1
    fi

    # Ensure the file exists after download
    if [[ ! -f "$TMP" ]]; then
        echo "Cover image not downloaded correctly."
        return 1
    fi

    # Get the current song name to generate a unique filename
    SONG_NAME=$(playerctl metadata title)
    ARTIST_NAME=$(playerctl metadata artist)
    # Clean up song and artist name to make a valid filename
    FILE_NAME=$(echo "$SONG_NAME - $ARTIST_NAME.jpg" | sed 's/[^a-zA-Z0-9]/_/g')  # Replace invalid characters with underscores

    # Save the cover image with a unique name
    mv "$TMP" "$COVER_DIR/$FILE_NAME"

    # Update Fastfetch JSON config to use the new cover image
    # Use jq to safely update the JSON file (install jq if not installed)
    jq --arg imagePath "$COVER_DIR/$FILE_NAME" \
       '.logo.source = $imagePath' \
       "$FASTFETCH_CONFIG" > "$FASTFETCH_CONFIG.tmp" && mv "$FASTFETCH_CONFIG.tmp" "$FASTFETCH_CONFIG"

    # Optionally, trigger Fastfetch to update
    pkill -USR1 fastfetch  # Sends a signal to Fastfetch to refresh its display
    echo "Updated Fastfetch with new cover image: $imagePath"
    return 0
}

# Monitor song changes and update album art in real-time
while true; do
    update_cover
    sleep 5  # Check for song change every 5 seconds (adjust as needed)
done
