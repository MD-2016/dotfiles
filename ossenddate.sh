#!/bin/bash

START_DATE=$(stat / | grep Birth | awk '{print $2" "$3}')

START_SEC=$(date -d "$START_DATE" +%s)
END_SEC=$(date -d "$START_DATE +1 year" +%s)
NOW_SEC=$(date +%s)

REMAINING=$((END_SEC - NOW_SEC))

if [ $REMAINING -le 0 ]; then
	echo "Run Ended!"
	exit 0
fi

DAYS=$((REMAINING / 86400))
HOURS=$(((REMAINING % 86400) / 3600))
MINUTES=$(((REMAINING % 3600) / 60))

echo "$DAYS d $HOURS h $MINUTES m left"
