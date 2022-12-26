#!/bin/bash

# check if the argument is a pdf file
if [[ $1 == *.pdf ]]; then
  # remove any path from the input string and just get the filename
  filename=$(basename "$1")
  # create an output folder
  mkdir output
  # convert the pdf file to an ODT document using LibreOffice
  libreoffice --headless --convert-to odt "$1" "output/${filename%.*}.odt"
else
  echo "Error: input must be a pdf file"
fi

