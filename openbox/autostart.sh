# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

docker &

setxkbmap -model geniuscomfy2 -layout "lv,ru(winkeys)" -option "grp:caps_toggle" &
feh --bg-tile ~/Images/wpaps/background-2.jpg &
urxvtd &
