#!/bin/sh

# execute any pre-exec scripts, useful for images
# based on this image
if [ -d "/scripts" ]; then
	echo "Looking for user scripts to execute..."
	for i in /scripts/*sh
	do
    	if [ -e "${i}" ]; then
        	echo "[i] user script - processing $i"
        	. "${i}"
    	fi
	done
fi


# set apache as owner/group
if [ "$FIX_OWNERSHIP" != "" ]; then
	chown -R apache:apache /app
fi

if [ -f '/var/log/apache2/error.log' ]; then
        echo "Tailing existing Apache error.log"
else
        touch /var/log/apache2/error.log
fi

# display logs
tail -F /var/log/apache2/error.log &

echo "[i] Starting daemon..."
# run apache httpd daemon
httpd -D FOREGROUND
