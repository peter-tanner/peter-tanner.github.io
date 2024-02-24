#!/bin/bash

# Function to convert JPG/JPEG to PNG
convert_to_png() {
    local file="$1"
    local filename="${file%.*}"  # Remove extension
    local new_file="${filename}.png"

    echo "Converting $file to PNG..."
    convert "$file" "$new_file"
    echo "Converted $file to PNG: $new_file"

    # Update file variable to the new PNG file
    file="$new_file"
}

# Loop through all preview.jpg and preview.jpeg files in assets/img/<folder> directories
for file in assets/img/*/{preview.jpg,preview.jpeg}; do
    if [ -f "$file" ]; then
        # Convert JPG/JPEG to PNG
        convert_to_png "$file"
    fi
done


# Loop through all preview.png files in assets/img/<folder> directories
for file in assets/img/*/preview.png; do
    if [ -f "$file" ]; then
        # Get current dimensions
        current_width=$(identify -format "%w" "$file")
        current_height=$(identify -format "%h" "$file")

        # Calculate new dimensions, keeping aspect ratio
        new_width=1200
        new_height=630
        if [ "$current_width" -gt "$new_width" ] || [ "$current_height" -gt "$new_height" ]; then
            # Resize only if current dimensions exceed the new dimensions
            convert "$file" -resize "${new_width}x${new_height}>" "$file"
            echo "Resized $file"
        # else
            # echo "No need to resize $file"
        fi
    fi
done