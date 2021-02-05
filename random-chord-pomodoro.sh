#!/usr/bin/env bash

chord=$(./random-chord)

messages=$(cat <<EOF
Sax time!!!
Strap sax on!
Try it!
Put your musician hat on...
EOF
	)
message=$(echo "$messages" | sort --random-sort | head -1)


case $* in
    one)
	echo "${chord}"
	echo -n ""
	;;
    *)
	exec >>~/random-chord.log 2>~/random-chord.err
	echo -n "${chord} "
	osascript -e "display notification \"${message}\" with title \"${chord}\" sound name \"Submarine\""
	osascript -e "display dialog \"${chord}\" with title \"${message}\" buttons {\"Cool\", \"Skip\"} with icon alias \"Macintosh HD:Applications:GarageBand.app:Contents:Resources:StandardMIDIFile.icns\""
	date
	echo "Waiting for 25 min..."
	sleep 1500 # 25 min
	echo ""
	exec "$0"
	;;
esac
