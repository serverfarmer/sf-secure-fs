#!/bin/sh
. /opt/farm/scripts/init

if [ "$OSTYPE" = "netbsd" ]; then
	echo "skipping secure filesystem setup, unsupported system"
	exit 0
fi

if ! grep -q /opt/farm/ext/secure-fs/cron/check.sh /etc/crontab; then
	sed -i -e "/scripts\/check\/security.sh/d" /etc/crontab
	echo "22 1 * * * root /opt/farm/ext/secure-fs/cron/check.sh" >>/etc/crontab
fi

/opt/farm/ext/secure-fs/cron/check.sh
