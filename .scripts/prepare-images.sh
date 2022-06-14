#!/bin/bash
for i in *.HEIC
do 
	heif-convert $i ${i%.HEIC}.jpg
done

for i in *.jpg
do 
	convert -resize 1920x1080 $i $i
done

for i in *.jpg
do 
	jpegoptim --size=500k $i
done
