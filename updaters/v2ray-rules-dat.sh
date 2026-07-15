#!/bin/bash

set -x

if ! curl -sL https://api.github.com/repos/Loyalsoldier/v2ray-rules-dat/releases/latest > /tmp/v2raya-rules-dat.json; then
    echo "GitHub API rate limit exceeded, please try again later."
    exit
fi
latest_version=$(cat /tmp/v2raya-rules-dat.json | jq -r '.tag_name')
if [ "$latest_version" == "null" ]; then
    echo "GitHub API rate limit exceeded, please try again later."
    exit
fi
current_version=$(cat ./Formula/v2ray-rules-dat.rb | grep 'v2rayRulesDat_version =' | awk -F '"' '{print $2}')
if [ "$current_version" != "$latest_version" ]; then
    if ! curl -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$latest_version/geosite.dat.sha256sum > /tmp/v2raya-rules-dat-geosite.sha256; then
        echo "GitHub API rate limit exceeded, please try again later."
        exit
    else
        latest_sha_geosite="$(cat /tmp/v2raya-rules-dat-geosite.sha256 | awk '{print $1}')"
    fi
    if ! curl -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$latest_version/geoip.dat.sha256sum > /tmp/v2raya-rules-dat-geoip.sha256; then
        echo "GitHub API rate limit exceeded, please try again later."
        exit
    else
        latest_sha_geoip="$(cat /tmp/v2raya-rules-dat-geoip.sha256 | awk '{print $1}')"
    fi
    cat ./templates/v2ray-rules-dat.rb | sed "s|TheRealVersion|$latest_version|g" > ./Formula/v2ray-rules-dat.rb
    sed -i "s|RealSha256_Geosite|$latest_sha_geosite|g" ./Formula/v2ray-rules-dat.rb
    sed -i "s|RealSha256_Geoip|$latest_sha_geoip|g" ./Formula/v2ray-rules-dat.rb
    git commit ./Formula/v2ray-rules-dat.rb -m "v2ray-rules-dat: update to $latest_version"
else
    echo "Nothing to do, you have the latest version of v2ray-rules-dat."
fi