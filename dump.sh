#!/bin/bash

DUMP_DIR=/home/dump
SITES_DIR=/var/www/sites
USERNAME=username

mkdir -p $DUMP_DIR &> /dev/null
cd $DUMP_DIR

echo "Dumping databases..";
echo "Enter MySQL user password";
mysqldump -u$USERNAME -p --all-databases -v > databases.sql

if [ $? -ne 0 ]; then
	echo "An error occured while dumping all databases";
	exit 1;
fi

echo "Packing databases dump...";
gzip databases.sql

echo "Creating copies for every site...";

for file in `ls -1 $SITES_DIR`; do
	echo "Creating backup for $file...";
	if [ ! -f $DUMP_DIR/$file.tar.gz ]; then
		tar czvf $DUMP_DIR/$file.tar.gz -C $SITES_DIR $file
	fi
done
