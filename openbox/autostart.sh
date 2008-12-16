# dbus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# set wallpaper
case "$HOSTNAME" in
  delta.scwlab.com)
    feh --bg-tile ~/Images/wpaps/background-2.jpg &
    ;;
  work.scwlab.com)
    feh --bg-center ~/Pictures/wpaps/fire-final.jpg &
    ;;
  *)
    xsetroot -solid "#303030"
    ;;
esac

# utils
docker &
urxvtd &

# keyboard layout
setxkbmap -model geniuscomfy2 -layout "lv,ru(winkeys)" -option "grp:caps_toggle" &
