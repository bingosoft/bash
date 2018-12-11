#!/bin/bash

# generate xcassets with proper size from folders with jpeg images

SIZE_2X="640x360";
IMAGES_PATH=`pwd`/../images
RES_DIR=`pwd`/Images.xcassets/images/

mkdir $RES_DIR &> /dev/null

cd $IMAGES_PATH

for file in *.jpg; do
	echo "Converting $file...";
	name="${file%.jpg}";
	mkdir "$RES_DIR/$name.imageset" &> /dev/null;
	convert "$file" -resize $SIZE_2X "$RES_DIR/$name.imageset/${name}_2x.jpg";
	echo -n \
'{
  "images" : [
    {
      "idiom" : "universal",
      "scale" : "1x"
    },
    {
      "idiom" : "universal",
      "scale" : "2x",
      "filename" : "'${name}'_2x.jpg"
    },
    {
      "idiom" : "universal",
      "scale" : "3x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}' > "$RES_DIR/$name.imageset/Contents.json";
done
