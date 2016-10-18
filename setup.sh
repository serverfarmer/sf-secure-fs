#!/bin/sh
. /opt/farm/scripts/init

if ! grep -q /opt/farm/ext/secure-fs/cron/check.sh /etc/crontab && [ "$OSTYPE" != "netbsd" ]; then
	sed -i -e "/scripts\/check\/security.sh/d" /etc/crontab
	echo "22 1 * * * root /opt/farm/ext/secure-fs/cron/check.sh" >>/etc/crontab
fi

/opt/farm/ext/secure-fs/cron/check.sh
