#!/bin/bash

WEBHOME=/home/alister/storage/web/Hosts

mkdir -p $WEBHOME/php.local/
cd $WEBHOME/php.local/
rsync -azCq --timeout=600 --delete --delete-after \
      rsync.php.net::phpweb $WEBHOME/php.local \
      --include='manual/en/' --include='manual/en/**' --exclude='manual/**' \
      --exclude='distributions/**' --exclude='extra/**' --exclude=".git"
