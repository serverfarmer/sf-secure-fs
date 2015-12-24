#!/bin/bash

if ! grep -q /opt/sf-secure-fs/cron/check.sh /etc/crontab; then
	sed -i -e "/scripts\/check\/security.sh/d" /etc/crontab
	echo "22 1 * * * root /opt/sf-secure-fs/cron/check.sh" >>/etc/crontab
fi

/opt/sf-secure-fs/cron/check.sh
