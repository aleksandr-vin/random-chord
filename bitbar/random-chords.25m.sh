#!/bin/sh
set -e

#echo "$1" >> ~/random-chord.debug

case "$1" in
    mute)
        touch ~/random-chord.muted
        exit 0
        ;;
    unmute)
        rm -f ~/random-chord.muted
        exit 0
        ;;
    *)
        ;;
esac

chord=$(~/local/bin/random-chord)

messages=$(cat <<EOF
Sax time!!!
Strap sax on!
Try it!
Put your musician hat on...
EOF
	)
message=$(echo "$messages" | sort --random-sort | head -1)

if [[ -r ~/random-chord.muted ]]
then
    echo ":saxophone:"
    echo ---
    echo "Unmute | bash=\"${0}\" param1=unmute terminal=false refresh=true"
    exit 0
fi

(
    echo -n "${chord} "
    osascript -e "display notification \"${message}\" with title \"${chord}\" sound name \"Blow\""
    osascript -e "display dialog \"${chord}\" with title \"${message}\" buttons {\"Cool\", \"Skip\"} with icon alias \"Macintosh HD:Applications:GarageBand.app:Contents:Resources:StandardMIDIFile.icns\""
    date
    echo ""
) >>~/random-chord.log 2>~/random-chord.err &


echo "${chord} :saxophone: | color=blue"

echo ---

echo "Refresh | refresh=true color=red"
echo "Mute | bash=\"${0}\" param1=mute terminal=false refresh=true"
