---
title: Automatically push Altium to GitHub
author: Peter Tanner
date: 2023-08-05 22:43:22 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [getting started, altium, github, git] # systems | embedded | rf | microwave | electronics | solidworks | automation
---

## Motivation

Altium has their Altium365 cloud service, which includes Git version control. I wanted to mirror my Altium project to GitHub to add to my portfolio, since my GitHub currently has a lot of programming but not so much embedded projects to show.

Adding a new remote is the most obvious solution.

```bash
git remote add gh https://github.com/OWNER/REPOSITORY.git    # gh remote is for github
git push gh master
```

There are several issues:

1. Altium does not work with `ssh` connections, only HTTPS. This is not a problem if you use HTTPS on GitHub.
2. I had issues with Altium recognizing the `gh` remote as the primary remote, instead of the Altium 365 remote. Obviously, Altium doesn't seem designed to deal with multiple remotes.
3. The largest issue is that Altium sets up the `user.email` with the format `$NAME@$DOMAIN@$MACHINE_NAME`. This email format is not accepted on GitHub, so the commits do not get attributed to your GitHub account, and they appear in a 'raw' form as:
   > `$EMAIL` authored and `$EMAIL` comitted on `$DATE`.

So I bodged together a script to resolve these issues which is probably against all good Git practice, but whatever (I'm not planning to have users contribute to the GitHub side - it will only be a read-only remote).

```bash
git filter-branch --env-filter '
export GIT_AUTHOR_EMAIL=${GIT_AUTHOR_EMAIL%@*}
export GIT_COMMITTER_EMAIL=${GIT_COMMITTER_EMAIL%@*}
' --tag-name-filter cat -- --branches --tags
```

This command will re-write history to remove everything after the second `@` symbol, including the machine name. As we are re-writing history, copy the repository to a new directory. Do not modify the original, since rewriting history is risky and Altium probably relies on the format including the machine name.

Anyway I ChatGPT'd the rest, but it

1. Copy all directories in a csv (`$directory_name,$remote_url`) to a `ZZZ_GITHUB` directory. Projects which are already in the github directory are compared by revision, and if the github copy is out of date then it is copied over.
2. Reset `--hard`, since the script will be run rarely and a project might be modified but not committed.
3. Rewrite history, remove machine name from author and committer emails.
4. Add new remote and push.

Here's the script, enjoy

```bash
#!/bin/bash

# Step 1: Create the "ZZZ_GITHUB" folder if it doesn't exist
mkdir -p ZZZ_GITHUB

# Step 2: Read the list of repository names from "repositories_list.txt" and copy only the listed repositories
while IFS=',' read -r directory remote_url || [ -n "$directory" ]; do
    echo "Processing repository: $directory"
    source_dir="$directory"
    target_dir="ZZZ_GITHUB/$directory"

    # Check if the source directory is a valid Git repository
    if [ -d "$source_dir/.git" ] && git -C "$source_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # Check if the target directory is not present or is out of date
        if [ ! -d "$target_dir" ] || ! git -C "$source_dir" diff-index --quiet HEAD -- "$source_dir"; then
            # Copy the repository to ZZZ_GITHUB
            echo "Copy: $directory . . ."
            rm -rf "$target_dir"
            cp -r "$source_dir" "$target_dir"
            echo "Repository copied: $directory"
            git -C "$target_dir" reset --hard HEAD
            git -C "$target_dir" filter-branch --env-filter '
            export GIT_AUTHOR_EMAIL=${GIT_AUTHOR_EMAIL%@*}
            export GIT_COMMITTER_EMAIL=${GIT_COMMITTER_EMAIL%@*}
            ' --tag-name-filter cat -- --branches --tags
            git -C "$target_dir" remote set-url origin "$remote_url"
            git -C "$target_dir" push --force origin HEAD
            echo "Copied repository pushed to the remote: $directory"
        else
            echo "Repository is up to date: $directory"
        fi
    else
        echo "Invalid Git repository or directory not found: $directory"
    fi
done < repositories_list.txt
```

You can see this script working for the [STM32WLE5 development board](https://github.com/peter-tanner/STM32WLE5-development-board).
