#!/bin/bash
#
# Stop the script if any command returns a non-zero exit status
set -e

# Define a directory where we will store the textfile that keeps track of
# downloaded PDFs
PDF_TRACKER_DIR="/tmp/pdf-tracker"

# Create the directory if it doesn't exist
mkdir -p "$PDF_TRACKER_DIR" || {
    echo "Error: Failed to create directory $PDF_TRACKER_DIR" >&2
    exit 1
}

# Use inotifywait to monitor the directory where PDFs are downloaded
# and open any new PDFs with Okular as they are downloaded
inotifywait -m -e create --format '%f' "$HOME/Downloads" | while read pdf; do
    if [[ $pdf == *.pdf ]]; then
	# Wait for the file to be completely downloaded before opening it
	# The maximum wait time is 1.3 seconds
	while [[ ! -s "$PDF_TRACKER_DIR/$pdf" ]] && [[ $i -lt 13 ]]; do
    	  sleep 0.1
    	  i=$(( i + 1 ))
	done
	# mv the downloaded file into the tmp dir
	mv "$HOME/Downloads/$pdf" $PDF_TRACKER_DIR	

        okular --unique "$PDF_TRACKER_DIR/$pdf" &
    fi
done

