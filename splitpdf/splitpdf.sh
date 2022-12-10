#!/bin/bash

# Check if the user provided a PDF file as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <pdf-file>"
  exit 1
fi

# Get the filename of the PDF file
pdf_file=$1

# Create a folder to store the split pages
mkdir ${pdf_file%.pdf}_pages

# Split the PDF into individual pages and store them in the folder
pdftk ${pdf_file} burst output output/${pdf_file%.pdf}_pages/page_%04d.pdf

echo "Split PDF pages are stored in ${pdf_file%.pdf}_pages folder."
