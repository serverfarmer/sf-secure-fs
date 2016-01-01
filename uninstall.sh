#!/bin/sh

if grep -q /opt/sf-secure-fs/cron /etc/crontab; then
	sed -i -e "/\/opt\/sf-secure-fs\/cron/d" /etc/crontab
fi
