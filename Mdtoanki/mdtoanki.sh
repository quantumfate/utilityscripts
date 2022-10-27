#!/bin/bash

# Params
# 1. Joplin md id
# 2. Module abbreviation
# 3. final deck name

# Modify the variables to fit your system

## By Joplin ID extracted markdown file
outputFile=$HOME/.script/Mdtoanki/resources/$1.md
## The folder where Joplin stores images
joplinImages=$HOME/.config/joplin-desktop/resources/
## The location of Joplin's sqlite database
joplinDbLocation=$HOME/.config/joplin-desktop/database.sqlite
## The location of the generated Anki deck
ankiDeckLocation=$HOME/ownCloud/HAWCloud/04Sem/anki/$2/$3.apkg
## The name of the Anki Deck
# :: in anki declares a subdeck
deckName=04_Sem::$2::$3

sqlite3 $joplinDbLocation "SELECT * from notes WHERE id = '$1'" > $outputFile

# Delete the first and last line
sed -i '/^$/d;1d;$d;/^|/d' $outputFile

# Replace images with absolute paths
sed -i -E "s|!\[(.*)\]\(:\/(.*)\)|![\1]($joplinImages\2.png)|" $outputFile

# Create a backup when the file to be generated already exists
if [ -f "$ankiDeckLocation" ]; then
	cp -pvi $ankiDeckLocation $ankiDeckLocation.$(date '+%Y-%d-%m-%s').bak
	rm $ankiDeckLocation
fi
mdanki $outputFile $ankiDeckLocation --deck $deckName
