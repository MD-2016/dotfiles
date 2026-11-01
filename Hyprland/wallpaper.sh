#!/bin/bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Check if the directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper Error" "Directory $WALLPAPER_DIR does not exist!"
    exit 1
fi

# Get a list of image files (adjust extensions as needed)
SELECTED_IMAGE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | rofi -dmenu -p "Select Wallpaper:")

# Exit if no image was selected
if [ -z "$SELECTED_IMAGE" ]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_DIR/$SELECTED_IMAGE"

# Check if hyprpaper is running, if not start it
if ! pgrep -x "hyprpaper" > /dev/null; then
    hyprpaper &
    sleep 0.5
fi

# Unload all previous wallpapers and preload the new one, then set it
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$FULL_PATH"
hyprctl hyprpaper wallpaper ", $FULL_PATH"

# Optional: Update hyprpaper.conf so it persists on reboot
sed -i "s|^preload =.*|preload = $FULL_PATH|" ~/.config/hypr/hyprpaper.conf
sed -i "s|^wallpaper =.*|wallpaper = , $FULL_PATH|" ~/.config/hypr/hyprpaper.conf

# Send a desktop notification
notify-send "Wallpaper Changed" "Set to: $SELECTED_IMAGE"
