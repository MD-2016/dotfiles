#!/usr/bin/env bash

# Define your preferred browser
BROWSER="xdg-open" # Uses your system default browser. Swap with "firefox" or "brave" if preferred.

# Step 1: Prompt the user to pick a search engine
ENGINE=$(printf "Google\nDuckDuckGo\nYouTube\nWikipedia\nSlackware\nReddit\nFlathub\nBleepingComputer\nAmazon\nLWN\nItsFOSS\nNoDQ" | rofi -dmenu -i -p "Search via:")

# If the user hits escape or doesn't pick anything, exit cleanly
if [ -z "$ENGINE" ]; then
    exit 1
fi

# Step 2: Prompt the user for the actual search term
QUERY=$(rofi -dmenu -p "Query ($ENGINE):")

# If query is empty, exit
if [ -z "$QUERY" ]; then
    exit 1
fi

# Step 3: Format the URL depending on the engine selected
case "$ENGINE" in
    Google)
        URL="https://google.com"
        ;;
    DuckDuckGo)
        URL="https://duckduckgo.com"
        ;;
    YouTube)
        URL="https://youtube.com"
        ;;
    Wikipedia)
        URL="https://wikipedia.org"
        ;;
    Slackware)
    	URL="http://www.slackware.com"
    	;;
    Reddit)
    	URL="https://www.reddit.com"
    	;;
    Flathub)
    	URL="https://www.flathub.org"
    	;;
    Amazon)
    	URL="https://www.amazon.com"
    	;;
    BleepingComputer)
    	URL="https://www.bleepingcomputer.com"
    	;;
    LWN)
    	URL="https://www.lwn.net"
    	;;
    ItsFOSS)
    	URL="https://itsfoss.com/"
    	;;
    NoDQ)
    	URL="https://nodq.com"
    	;;
        
    *)
        exit 1
        ;;
esac

# Step 4: Open the browser in the background so Rofi closes instantly
coproc ( $BROWSER "$URL" > /dev/null 2>&1 )
exec 1>&-
