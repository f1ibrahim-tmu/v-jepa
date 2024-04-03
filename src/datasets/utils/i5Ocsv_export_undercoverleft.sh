#!/bin/bash
# This script is to run the program one video at a time automatically (video paths variable takes a list of video path inputs), and ensure that each folder has only one videos.
#

for ARGUMENT in "$@"; do
	KEY=$(echo $ARGUMENT | cut -f1 -d=)

	KEY_LENGTH=${#KEY}
	VALUE="${ARGUMENT:$KEY_LENGTH+1}"

	export "$KEY"="$VALUE"
done

# Specify the root directory
videos_dir="/data/i5O/i5OData/undercover-left/videos/"
echo $videos_dir

# Specify the existing CSV file to append to
existing_csv="i5O_index_file.csv"
# Generate random number between 1 and 20 to represent class label
random_number=$(shuf -i 1-20 -n 1)

# Check if the directory exists
if [ -d "$videos_dir" ]; then
    # Find directories and their files
    for folder in $(find "$videos_dir" -mindepth 1 -maxdepth 1 -type d); do
        for file in $(find "$folder" -maxdepth 1 -type f -name "*.mp4"); do
            file="${file}"
            # Append absolute file path to existing CSV file
            echo "\"$file\", $random_number" >> "$existing_csv"
            # Generate a new random number for the next entry
            random_number=$(shuf -i 1-20 -n 1)
        done
    done
    echo "Data appended to $existing_csv"
else
    echo "Directory $videos_dir does not exist."
fi
