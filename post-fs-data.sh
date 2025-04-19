#!/system/bin/sh
MODDIR=${0%/*}
PACKAGES=$(cat $MODDIR/hidden_packages.txt)

for PKG in $PACKAGES; do
  PKG_PIDS=$(ps -A | grep $PKG | awk '{print $2}')
  for PID in $PKG_PIDS; do
    if [ -d "/proc/$PID" ]; then
      mount -o bind /dev/null /proc/$PID/cmdline
      if [ -f "/proc/$PID/status" ]; then
        TEMP_STATUS=$(mktemp)
        cat "/proc/$PID/status" | sed "s/$PKG/android.process.system/g" > $TEMP_STATUS
        mount -o bind $TEMP_STATUS "/proc/$PID/status"
        rm $TEMP_STATUS
      fi
    fi
  done
done
