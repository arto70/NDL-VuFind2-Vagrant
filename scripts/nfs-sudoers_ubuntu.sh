#!/usr/bin/env bash

DIR='/etc/sudoers.d/'
FILE=$DIR'vagrant-syncedfolders'

if [ ! -d "$DIR" ]; then
  sudo mkdir $DIR
fi
if [ ! -f "$FILE" ]; then
  sudo tee -a $FILE >/dev/null <<EOF
Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_EXPORTS_COPY = /bin/cp /tmp/exports /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /etc/init.d/nfs-kernel-server status
Cmnd_Alias VAGRANT_NFSD_START = /etc/init.d/nfs-kernel-server start
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /bin/sed -r -e * d -ibak /tmp/exports
%sudo ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY, VAGRANT_EXPORTS_REMOVE, VAGRANT_EXPORTS_COPY
EOF
fi
