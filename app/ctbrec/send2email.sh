#!/bin/sh

# send2email.sh ${absolutePath} [${modelDisplayName} ${localDateTime(yyyyMMdd-HHmmss)} ...]

file="$1"
sheet="${file%.*}.jpg"
length=`~/ctbrec/lib/ffmpeg/ffmpeg -i "$file" 2>&1 | grep "Duration" | cut -d ' ' -f 4 | sed s/,// | sed 's@\..*@@g'`
name=`basename $sheet`
shift

if [ -z "$1" ]; then
  content="Contact sheet"
else
  content="$1"
  shift
  for i in $@
  do
    content=`echo "${content} - ${i}"`
  done
fi
content=`echo "${content}: ${length}"`

encoded=`base64 $sheet`

echo -e "MIME-Version: 1.0\nSubject: $content\nContent-Type: multipart/mixed;\n  boundary=\"Delimiter\"\n\n--Delimiter\nContent-Type: image/jpeg;\n  name=$name\nContent-Disposition: attachment;\n  filename=$name\nContent-Transfer-Encoding: base64\n\n$encoded\n--Delimiter--\n" > ~/ctbrec/temp.txt

curl --url "$MAILSERVER" --ssl-reqd --mail-from "$MAILFROM" --mail-rcpt "$MAILTO" --upload-file '~/ctbrec/temp.txt' --user "$MAILFROM:$MAILPASS"

rm ~/ctbrec/temp.txt