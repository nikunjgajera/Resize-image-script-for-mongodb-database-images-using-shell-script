#!/bin/bash

#constants
RESIZED_IMAGE_DIR="/home/nikunjg/data/development/webroot/v2gui/images/highlightedprofile"
SITE_ID=$1
RESULT_FILE="mongoresult.txt"
FILE_NAMES="filenames.txt"
RESIZE_TO="135x174"
BACKGROUND="rgb(241,241,241)"
QUERY_FILE="query.js"


#get all file from mongo db
mongo --quiet --eval "var id=$SITE_ID" $QUERY_FILE > $RESULT_FILE

#get result to process
cat $RESULT_FILE | awk -F: '{print $3}' | awk -F\" '{print $2}' > $FILE_NAMES

while read line
do
    name=$line
    echo "Text read from file - $name"

		if [ ! -z "$name" -a "$name" != " " ]; then

			#get file from mongo
			mongofiles -d images get $name

			#convert image as per size
			convert $name -resize $RESIZE_TO -background $BACKGROUND -compose Copy -gravity center -extent $RESIZE_TO -quality 92 "$RESIZED_IMAGE_DIR/$name.jpg"

		fi

done < $FILE_NAMES

#----END-------