# Issue warning banner
sleep 2
zenity --title "WARNING" --no-wrap --question --text "`cat /etc/issue`\n\n`/etc/X11/xinit/xxx/lastuserlogin.pl $USER`\n\nContinue?\n"

if [ $? -ne 0 ]; then
  exit 1
fi
