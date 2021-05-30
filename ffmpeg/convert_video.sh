#!/bin/bash

# Dominik E. 30.05.2021


# VARIABLEN - HIER EDITIEREN
INPUT="/mnt/Freecom_HDD/ffmpeg/video/"
OUTPUT="/mnt/Freecom_HDD/ffmpeg/video/480p/"
INPUT_FORMAT="mp4"
OUTPUT_FORMAT="mp4"
OUTPUT_DEL=".mp4"
# ENDE VARIABLEN
mkdir -p $OUTPUT

# Video Konvertieren
cd "$INPUT" 
for i in *."$INPUT_FORMAT"; do 
	ffmpeg -i "$i" \
	-c:v libx264 \
	-tune film \
	-preset slow \
	-crf 26 \
	-vf scale=-1:288 \
	-acodec aac \
	-ar 44100 \
	-ac 2 \
	-ab 64k \
	"$OUTPUT$(basename "$i" "$OUTPUT_DEL").$OUTPUT_FORMAT" \
	;done
