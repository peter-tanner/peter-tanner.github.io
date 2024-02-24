#!/bin/bash

get_new_posts() {
    git status --porcelain=v1 _posts | grep -E '^\?\?' | cut -d ' ' -f 2 | tr '\n' ' '
}

# Function to generate the commit message
generate_commit_message() {
    printf "New posts: "
    get_new_posts
}

commit_msg="$(generate_commit_message)"
new_posts="$(get_new_posts)"

# Check if there are any new or modified files to commit
if [ -n "$new_posts" ]; then

    ./generate-preview-images.sh

    # Add all new and modified files
    echo "$commit_msg"
    git add $new_posts
    for post in $new_posts; do
        echo $post

        sed 's|](../|](/|' -i "$post" # make markdown images absolute

        post="${post#_posts/}"
        post="${post%.md}"
        git add "assets/img/${post:0:31}"
    done

    # Commit the changes with the generated message
    git commit -m "$commit_msg"
    git push
    echo "Changes committed successfully."
else
    echo "No new or modified files to commit."
fi
