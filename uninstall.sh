#!/bin/sh

if grep -q /opt/farm/ext/secure-fs/cron /etc/crontab; then
	sed -i -e "/\/opt\/farm\/ext\/secure-fs\/cron/d" /etc/crontab
fi
