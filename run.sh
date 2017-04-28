#!/bin/sh

# execute any pre-exec scripts, useful for images
# based on this image
for i in /scripts/*sh
do
    if [ -e "${i}" ]; then
        echo "[i] user script - processing $i"
        . "${i}"
    fi
done

# set apache as owner/group
if [ "$FIX_OWNERSHIP" != "" ]; then
	chown -R apache:apache /app
fi

# display logs
tail -F /var/log/apache2/*log &

echo "[i] Starting daemon..."
# run apache httpd daemon
httpd -D FOREGROUND
