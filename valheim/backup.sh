#!/bin/bash
TOBEBACKEDUP=""
BACKUPPATH="$1"

TEMPPATH=$(mktemp)
tar -czf $TEMPPATH "$TOBEBACKEDUP"
CHECKSUM=$(cat $TEMPPATH | md5sum)
echo $CHECKSUM
if [ -f "$BACKUPPATH/latest.md5sum" ]
then 
	echo "nothing to init"
else 
	echo "" > "$BACKUPPATH/dummy.tar.gz"
	echo "" > "$BACKUPPATH/dummy.md5sum"
	ln -s "$BACKUPPATH/dummy.md5sum" "$BACKUPPATH/latest.md5sum"
fi
if [ "$(cat $BACKUPPATH/latest.md5sum)" == "$(echo $CHECKSUM)" ]
then
	echo "nothing to do"
	rm $TEMPPATH
else
	if [ $(ls $BACKUPPATH | wc -l) -ge 20 ]
	then
		#delete the two oldest files
		cd $BACKUPPATH && rm "$(ls -t | tail -1)" && rm "$(ls -t | tail -1)"
	fi
	rm "$BACKUPPATH/latest.md5sum"
	TIMESTAMP="$(date --utc --iso-8601=minutes)"
	mv $TEMPPATH "$BACKUPPATH/$TIMESTAMP.tar.gz"
	echo -n $CHECKSUM > "$BACKUPPATH/$TIMESTAMP.md5sum"
	ln -s "$BACKUPPATH/$TIMESTAMP.md5sum" "$BACKUPPATH/latest.md5sum"
fi
