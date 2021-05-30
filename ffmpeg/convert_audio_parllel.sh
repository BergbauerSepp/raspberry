#!/bin/bash

# Von Dominik E. 30.05.2021

# VARIABLEN - HIER EDITIEREN
IN="/mnt/Freecom_HDD/audio/quelle/"
OUT="/mnt/Freecom_HDD/audio/ziel/"
IN_FORMAT="mp3"


OUT_CONTAINER="opus"
OUT_DEL=".MP3"

AUDIO_CODE="opus"
BITRATE="16k"


# ENDE VARIABLEN

cd "$IN" 
parallel --eta ffmpeg -i {} -qscale:a 0 -acodec "$AUDIO_CODE" -ab "$BITRATE" "$OUT{.}"."$OUT_CONTAINER" ::: ./*"$IN_FORMAT"
