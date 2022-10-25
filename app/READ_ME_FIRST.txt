NOTE: {version} refers to whatever is currently there, NOT LITERALLY.

To build the image you need the following in this directory:

1. Download the current ctbrec-{version}-linux-jre.zip archive.
2. Extract the contents of the archive here.
3. Edit the ctbrec.sh file so that:

$JAVA -Xmx1g -Djdk.gtk.version=3 -Dfile.encoding=utf-8 -jar ctbrec-{version}.jar

   becomes:

$JAVA -Xmx1g -Djdk.gtk.version=3 -Dfile.encoding=utf-8 -Dctbrec.config.dir=./config -jar ctbrec-{version}.jar


NOTE: The are four files already in the ctbrec directory:
      ctbrec.png           - used for the Desktop icon
      send2discord.sh      - sends the contact sheet to Discord
      send2email.sh        - sends the contact sheet to email
      send2telegram.sh     - sends the contact sheet to Telegram

Refer to jafea7/ctbrec-debian on how to use the last three scripts.
