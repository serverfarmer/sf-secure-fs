#!/bin/bash
# This script periodically checks and (if needed) restores secure permissions
# on directories, whose contents shouldn't be visible to ordinary users.
# Tomasz Klim, Aug 2014, Jan 2015, Jan 2018


chmod a-rwx /usr/lib/gcc/* 2>/dev/null
chmod 0700 /srv/rsync/* 2>/dev/null
chmod 0711 /srv/sites/* 2>/dev/null
chmod 0711 /srv/isync/* 2>/dev/null
chmod 0711 /srv/imap/* 2>/dev/null
chmod 0711 /home/* 2>/dev/null

GENERIC=(
	/app
	/backup
	/boot
	/etc
	/etc/apache2
	/etc/apache2/sites-available
	/etc/apache2/sites-enabled
	/etc/apt
	/etc/courier
	/etc/iet
	/etc/iscsi
	/etc/lighttpd
	/etc/local
	/etc/logrotate.d
	/etc/mfs
	/etc/motion
	/etc/mysql
	/etc/nagios
	/etc/nagios/nrpe.d
	/etc/nginx
	/etc/nginx/sites-available
	/etc/nginx/sites-enabled
	/etc/samba
	/etc/sysctl.d
	/etc/udev
	/etc/udev/rules.d
	/home
	/media
	/mnt
	/opt
	/srv
	/srv/apps
	/srv/chunks
	/srv/cifs
	/srv/imap
	/srv/isync
	/srv/rsync
	/srv/sites
	/srv/mounts
	/srv/mounts/backup
	/srv/mounts/internal1
	/srv/mounts/internal2
	/srv/mounts/internal3
	/srv/mounts/internal4
	/srv/mounts/shadow1
	/srv/mounts/shadow2
	/srv/mounts/shadow3
	/srv/mounts/shadow4
	/var/backups
	/var/cache
	/var/lib
	/var/spool
	/var/www
)

SAMBA=(
	/srv/mounts/internal1
	/srv/mounts/internal2
	/srv/mounts/internal3
	/srv/mounts/internal4
	/srv/mounts/moosefs
)


for D in ${GENERIC[@]}; do
	if [ -d $D ]; then
		perm=`stat -L -c %a:%U:%G $D`
		if [ "$perm" != "711:root:root" ]; then
			msg="directory $D had rights:owner 0$perm, fixed"
			if tty -s; then
				echo "$msg"
			else
				logger -p auth.notice -t secure-fs "$msg"
			fi
			chown root:root $D
			chmod 0711 $D
		fi
	fi
done

for D in ${SAMBA[@]}; do
	for P in `ls -d $D/samba* 2>/dev/null`; do
		perm=`stat -c %a:%U:%G $P`
		if [ "$perm" != "750:root:sambashare" ]; then
			msg="directory $P had rights:owner 0$perm, fixed"
			if tty -s; then
				echo "$msg"
			else
				logger -p auth.notice -t secure-fs "$msg"
			fi
			chown root:sambashare $P
			chmod 0750 $P
		fi
	done
done
