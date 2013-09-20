#!/bin/bash

DIR=/Users/localadmin/Desktop

pre (){

	WAV=$DIR.wav
	FLAC=$DIR.flac
	JSON=$DIR.json
	ALL=( $JSON, $WAV, $FLAC )

	for i in "${ALL[@]}"
	do 
	if [ -f "${i}" ]; then rm "${i}"; fi
	done


	SAY="In everyday speech, a phrase may refer to any group of words. In linguistics, a phrase is a group of words (or sometimes a single word) that form a constituent and so function as a single unit in the syntax of a sentence. A phrase is lower on the grammatical hierarchy than a clause."

	say --data-format=LEF32@16000 -o 
	ffmpeg -i $WAV $FLAC
}

FLAC="${DIR}/spoken.flac"
echo $FLAC
JSON="${DIR}/spoken.json"
echo $JSON
GOOG=google.com#74.125.228.3

URL="https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=en-US"
#http://www.$GOOG/speech-api/v1/recognize?&client=chromium"
#&lang=en-QA&maxresults=10

#curl -X POST \
#--data-binary $FLAC \
#--user-agent 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7' \
#--header 'Content-Type: audio/x-flac; rate=16000;' \
#'https://www.google.com/speech-api/v1/recognize?client=chromium'
#
#extip
wget -4 --post-file=$FLAC \
--user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.33 (KHTML, like Gecko) Chrome/27.0.1427.3 Safari/537.33' \
--header='Content-Type: audio/x-flac; rate=16000;' -S -O $JSON $URL

#Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7' \

#'http://www.google.com/speech-api/v1/recognize?&client=chromium'
#xjerr=1
#'https://www.google.com/speech-api/v1/recognize?client=chromium'
#&lang=ar-QA&maxresults=10'

mate $JSON