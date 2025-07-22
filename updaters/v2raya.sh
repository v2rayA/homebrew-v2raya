#!/bin/bash

set -x

if ! curl -sL https://api.github.com/repos/v2rayA/homebrew-v2raya/releases/latest > /tmp/v2raya.json; then
    echo "GitHub API rate limit exceeded, please try again later."
    exit
fi
latest_version=$(cat /tmp/v2raya.json | jq -r '.tag_name')
if [ "$latest_version" == "null" ]; then
    echo "GitHub API rate limit exceeded, please try again later."
    exit
fi
current_version=$(cat ./Formula/v2raya.rb | grep 'v2rayA_version =' | awk -F '"' '{print $2}')
if [ "$current_version" != "$latest_version" ]; then
    if ! curl -sL https://github.com/v2rayA/homebrew-v2raya/releases/download/$latest_version/v2raya-x86_64-linux.zip.sha256.txt > /tmp/v2raya-linux.sha256; then
        echo "GitHub API rate limit exceeded, please try again later."
        exit
    else
        latest_sha_linux_x64="$(cat /tmp/v2raya-linux.sha256 | awk '{print $1}')"
    fi
    if ! curl -sL https://github.com/v2rayA/homebrew-v2raya/releases/download/$latest_version/v2raya-x86_64-macos.zip.sha256.txt > /tmp/v2raya-macos.sha256; then
        echo "GitHub API rate limit exceeded, please try again later."
        exit
    else
        latest_sha_macos_x64="$(cat /tmp/v2raya-macos.sha256 | awk '{print $1}')"
    fi
    if ! curl -Ls https://github.com/v2rayA/homebrew-v2raya/releases/download/$latest_version/v2raya-aarch64-macos.zip.sha256.txt > /tmp/v2raya-macos-arm64.sha256; then
        echo "GitHub API rate limit exceeded, please try again later."
        exit
    else
        latest_sha_macos_arm64="$(cat /tmp/v2raya-macos-arm64.sha256 | awk '{print $1}')"
    fi
    cat ./templates/v2raya.rb | sed "s|TheRealVersion|$latest_version|g" > ./Formula/v2raya.rb
    sed -i "s|RealSha256_MacOS_arm64|$latest_sha_macos_arm64|g" ./Formula/v2raya.rb
    sed -i "s|RealSha256_MacOS_x64|$latest_sha_macos_x64|g" ./Formula/v2raya.rb
    sed -i "s|RealSha256_Linux_x64|$latest_sha_linux_x64|g" ./Formula/v2raya.rb
    git commit ./Formula/v2raya.rb -m "v2raya: update to $latest_version"
else
    echo "Nothing to do, you have the latest version of v2raya."
fi
