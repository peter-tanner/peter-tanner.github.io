#!/bin/bash

get_new_posts() {
    git status --porcelain=v1 _posts | grep -E '^\?\?' | cut -d ' ' -f 2 | tr '\n' ' '
}

# Function to generate the commit message
generate_commit_message() {
    printf "New posts: "
    get_new_posts
}

# Check if there are any new or modified files to commit
if [ -n "$(get_new_posts)" ]; then
    # Add all new and modified files
    echo "$(generate_commit_message)"
    git add $(get_new_posts)

    # Commit the changes with the generated message
    git commit -m "$(generate_commit_message)"
    git push
    echo "Changes committed successfully."
else
    echo "No new or modified files to commit."
fi
