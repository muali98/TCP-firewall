#!/bin/bash

if [ "$1" == "init" ]; then
    if [ $# -ne 2 ]; then
        echo "Please supply a git clone URL!"
        echo ""
        echo "syntax: $0 init <git-clone-url-of-your-repo>"
        exit 1
    fi
    if git remote show | grep "template" >/dev/null 2>&1; then
        echo "This repository is already forked! Stubbornly refusing to initialise."
        exit 2
    fi
    echo "Setting up fork:"
    echo "  $git_remote_url -> $2"
    git_branch="$(git rev-parse --abbrev-ref HEAD)"
    git_remote="$(git remote show)"
    git_remote_url="$(git remote get-url $git_remote)"
    git_username="$(git config --list | grep "user.name" | awk -F= '{print $2}')"
    git remote rm "$git_remote"
    git remote add origin "$2"
    git remote add template "$git_remote_url"
    git push --set-upstream origin "$git_branch"
    # fix remotes if push failed
    if [ $? -ne 0 ]; then
        git remote rm template
        git remote rm origin
        git remote add origin "$git_remote_url"
    fi
elif [ "$1" == "update" ]; then
    git_branch="$(git rev-parse --abbrev-ref HEAD)"
    git pull template "$git_branch"
    if [ $? -eq 0 ]; then
        git push origin "$git_branch"
    fi
else
    echo "syntax: $0 init <git-clone-url-of-your-repo>"
    echo "        $0 update"
    exit 0
fi

