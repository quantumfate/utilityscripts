#!/bin/bash
#
# Stop the script if any command returns a non-zero exit status
set -e

# Define a directory where we will store the textfile that keeps track of
# downloaded PDFs
PDF_TRACKER_DIR="$HOME/.pdf-tracker"

# Create the directory if it doesn't exist
mkdir -p "$PDF_TRACKER_DIR" || {
    echo "Error: Failed to create directory $PDF_TRACKER_DIR" >&2
    exit 1
}

# Define the path to the textfile
PDF_TRACKER_FILE="$PDF_TRACKER_DIR/downloaded-pdfs.txt"

touch -c "$PDF_TRACKER_FILE" || {
    echo "Error: Failed to create File $PDF_TRACKER_FILE" >&2
    exit 1
}

# Delete all PDFs listed in the textfile on system startup
rm -f $(cat "$PDF_TRACKER_FILE")

# Clear the list of downloaded PDFs
echo -n > "$PDF_TRACKER_FILE"

# Use inotifywait to monitor the directory where PDFs are downloaded
# and open any new PDFs with Okular as they are downloaded
inotifywait -m -e create --format '%f' "$HOME/Downloads" | while read pdf; do
    if [[ $pdf == *.pdf ]]; then
	
	# Wait for the file to be completely downloaded before opening it
	# The maximum wait time is 1.3 seconds
	while [[ ! -s "$HOME/Downloads/$pdf" ]] && [[ $i -lt 13 ]]; do
    	  sleep 0.1
    	  i=$(( i + 1 ))
	done

        okular --unique "$HOME/Downloads/$pdf" &
        # Add the PDF to the list of downloaded PDFs
        echo "$HOME/Downloads/$pdf" >> "$PDF_TRACKER_FILE"
    fi
done

