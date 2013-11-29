#!/bin/bash

### Configuration ###

# Number of seconds to sleep after module removal.
SLEEP_TIME=3
# Number of seconds to wait after the last keypress before re-enabling the touchpad.
IDLE_TIME=0.3
# Enable palm detect?
PALM_DETECT=0
# Minimum finger width which is considered a palm.
PALM_MIN_WIDTH=5
# Minimum finger pressure at which a touch is considered a palm.
PALM_MIN_Z=50
# Which mouse button is associated with a one-finger tap.
TAP_BUTTON_1=1
# Which mouse button is associated with a two-finger tap.
TAP_BUTTON_2=3
# Which mouse button is associated with a three-finger tap.
TAP_BUTTON_3=2
# Faster reaction to single taps?  Also makes double-taps slower.
FAST_TAPS=0
# Timeout after a tap to recognize it as a single-tap.
SINGLE_TAP_TIMEOUT=180
# Maximum time in milliseconds for detecting a tap.
MAX_TAP_TIME=180
# Define left border.  Events to the left of this will be ignored.
AREA_LEFT_EDGE=529
# Define right border.  Events to the right of this will be ignored.
AREA_RIGHT_EDGE=2720

### Script ###

/sbin/rmmod psmouse
/sbin/modprobe psmouse
/bin/sleep $SLEEP_TIME
/usr/bin/killall syndaemon

/usr/bin/syndaemon -i $IDLE_TIME -K -R 1>&2 &
/usr/bin/synclient  PalmDetect=$PALM_DETECT \
                    PalmMinWidth=$PALM_MIN_WIDTH \
                    PalmMinZ=$PALM_MIN_Z \
                    TapButton3=$TAP_BUTTON_3 \
                    TapButton1=$TAP_BUTTON_1 \
                    TapButton2=$TAP_BUTTON_2 \
                    FastTaps=$FAST_TAPS} \
                    SingleTapTimeout=$SINGLE_TAP_TIMEOUT \
                    MaxTapTime=$MAX_TAP_TIME \
                    AreaLeftEdge=$AREA_LEFT_EDGE \
                    AreaRightEdge=$AREA_RIGHT_EDGE
