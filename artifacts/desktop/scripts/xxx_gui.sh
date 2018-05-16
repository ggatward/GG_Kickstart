#!/bin/bash

FF_PREFS=$(find /home/$LOGNAME/.mozilla/firefox/ -name prefs.js 2>/dev/null)

if [ -z $FF_PREFS ]; do
  echo "Creating Firefox Profile..."
  firefox &
  sleep 1; killall -9 firefox
  FF_PREFS=$(find /home/$LOGNAME/.mozilla/firefox/ -name prefs.js 2>/dev/null)
fi

if [ $(grep -c network.proxy.autoconfig_url $FF_PREFS) -eq 0 ]; then
  echo "Adding Firefox Proxy"
  echo "user_pref(\"network.proxy.autoconfig_url\", \"http://config.example.com/pac/proxy.pac\");" >> $FF_PREFS
  echo "user_pref(\"config.use_system_prefs\", false);" >> $FF_PREFS
  echo "user_pref(\"network.proxy.type\", 2);" >> $FF_PREFS 
else
  echo "Fixing Firefox Proxy Settings"
  sed -i "s|.*network.proxy.autoconfig_url.*|user_pref(\"network.proxy.autoconfig_url\", \"http://config.example.com/pac/proxy.pac\");|" $FF_PREFS
  sed -i "s|.*config.use_system_prefs.*|user_pref(\"config.use_system_prefs\", false);|" $FF_PREFS
  sed -i "s|.*network.proxy.type.*|user_pref(\"network.proxy.type\", 2);|" $FF_PREFS
fi

exit 0
