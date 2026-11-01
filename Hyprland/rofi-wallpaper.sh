#!/usr/bin/env bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

# Check if awww daemon is running, if not initialize it
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww init &
    sleep 1
fi

# Check if directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper Error" "Directory $WALLPAPER_DIR does not exist."
    exit 1
fi

# Get a list of image files
SELECTED=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.gif" \) -printf "%f\n" | sort | rofi -dmenu -p "Wallpaper:")

# If an image was selected, set it using awww
if [ -n "$SELECTED" ]; then
    FULL_PATH="$WALLPAPER_DIR/$SELECTED"
    awww img "$FULL_PATH" --transition-type fade --transition-duration 2 --resize fit
    notify-send "Wallpaper Changed" "$SELECTED"
fi
