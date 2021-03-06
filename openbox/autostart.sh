# dbus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# apply X resources
xrdb -merge ~/.dotswt/Xresources

# set wallpaper
case "$HOSTNAME" in
  delta.scwlab.com)
    feh --bg-tile ~/img/wpaps/background-2.jpg &
    ;;
  work.scwlab.com)
    feh --bg-center ~/Pictures/wpaps/fire-final.jpg &
    CONKYPARAMS='-x 3'
    ;;
  *)
    xsetroot -solid "#303030"
    ;;
esac

# utils
docker &
numlockx &
conky -q $CONKYPARAMS -c ~/.dotswt/conkyrc -d &

# mpd (if not running)
if [[ `ps --no-heading -C mpd | wc -l` -eq 0 ]]
  then mpd ~/.dotswt/mpd/mpd.conf
fi

# keyboard layout
setxkbmap -model logitech_base -layout "lv,ru" -option "grp:caps_toggle" -option "eurosign:5" &

# reasonable power saving
xset dpms 600 0 900
