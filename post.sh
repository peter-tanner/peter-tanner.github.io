#!/bin/bash

# Function to sanitize the title
sanitize_title() {
    title="$1"
    sanitized_title=$(echo "$title" | tr -dc 'a-zA-Z0-9 ')
    echo "$sanitized_title" | tr ' ' '-'
}

# Prompt the user for a title
read -e -p "Enter the title: " user_title

# Sanitize the title
sanitized_title=$(sanitize_title "$user_title")

# Generate the filename with the current date
current_date=$(date +'%Y-%m-%d')
filename="${current_date}-${sanitized_title}"
filepath="_posts/${filename}.md"

# Function to generate the front matter with the current date
generate_front_matter() {
    current_date=$(date +'%Y-%m-%d %H:%M:%S %z')
    echo "---"
    echo "title: $1"
    echo "author: peter"
    echo "date: $current_date"
    echo "categories: [Blogging]    # Blogging | Electronics | Programming | Mechanical | SelfHosting"
    echo "tags: [getting started]   # systems | embedded | rf | microwave | electronics | solidworks | automation | tip"
    echo "# image: assets/img/${filename:0:31}/preview.png"
    echo "---"
}

# Check if the file already exists
if [ -e "$filepath" ]; then
    echo "A file with the name '$filename' already exists in the '_posts' subdirectory."
else
    # Create the new file and add the front matter
    generate_front_matter "$user_title" > "$filepath"
    mkdir -p "assets/img/${filename:0:31}"
    echo "File '$filename.md' created successfully in the '_posts' subdirectory."
fi
