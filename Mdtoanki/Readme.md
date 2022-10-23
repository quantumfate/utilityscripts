# Markdown to anki Script

This script uses the [mdanki tool](https://github.com/ashlinchak/mdanki) to generate [anki decks](https://apps.ankiweb.net/) from [joplin notes](https://joplinapp.org/).

## Requirements

1. [mdanki](https://github.com/ashlinchak/mdanki) needs to be installed
2. [joplin notes](https://joplinapp.org/) needs to be installed
3. sqlite3 needs to be installed

### Some general rules for roles

Follow these steps to avoid unexpected behaviour

1. Your note has to have someting else than `##` as a first line. Preferably `#`.
2. Format your notes with `shift+alt+F`

## Usage

`mdtoanki <joplin note id> <folder> <deckname>`

joplin note id = $1
folder = $2
deckname = $3

## Example Usage

`./mdtoanki.sh 99500afd3d8941a6a69f7da429a35fe3 RN Internet`

Will look for the markdown file indetified by `99500afd3d8941a6a69f7da429a35fe3` and generate it to the folder containing `RN`. The deck name will be `Internet`.
