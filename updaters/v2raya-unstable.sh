#!/bin/bash

set -e

sudo apt install -y jq

latest_action_id=$(curl -s "https://api.github.com/repos/v2rayA/v2rayA/actions/workflows/release_feat_v5.yml/runs" | jq -r ".workflow_runs[0].jobs_url" | awk -F '/' '{printf $9}')
latest_version=$(curl -s "https://api.github.com/repos/v2rayA/v2rayA/actions/runs/$latest_action_id/artifacts" | jq -r ".artifacts[0].name" | awk -F '-' '{printf $2}')

url_linux_x64='https://nightly.link/v2rayA/v2rayA/actions/runs/'"$latest_action_id""/v2raya_linux_x64_unstable-$latest_version.zip"
url_darwin_x64='https://nightly.link/v2rayA/v2rayA/actions/runs/'"$latest_action_id""/v2raya_darwin_x64_unstable-$latest_version.zip"
url_darwin_arm64='https://nightly.link/v2rayA/v2rayA/actions/runs/'"$latest_action_id""/v2raya_darwin_arm64_unstable-$latest_version.zip"

echo "$url_linux_x64"
echo "$url_darwin_x64"
echo "$url_darwin_arm64"

current_url_linux_x64=$(cat ./Formula/v2raya-unstable.rb | grep 'url_linux_x64 =' | awk -F '"' '{print $2}')
current_url_darwin_x64=$(cat ./Formula/v2raya-unstable.rb | grep 'url_macos_x64 =' | awk -F '"' '{print $2}')
current_url_darwin_arm64=$(cat ./Formula/v2raya-unstable.rb | grep 'url_macos_arm64 ='  | awk -F '"' '{print $2}')
current_version=$(cat ./Formula/v2raya-unstable.rb | grep 'v2raya_version ='  | awk -F '"' '{print $2}')

if [ "$current_version" != "$latest_version" ]; then
    sed -i "s|$current_url_linux_x64|$url_linux_x64|g" ./Formula/v2raya-unstable.rb
    curl -sL "$url_linux_x64" -o v2raya_linux_x64.zip; sha_linux_x64=$(sha256sum v2raya_linux_x64.zip | awk '{print $1}'); rm v2raya_linux_x64.zip
    current_sha_linux_x64=$(cat ./Formula/v2raya-unstable.rb | grep 'sha_linux_x64 =' | awk -F '"' '{print $2}')
    sed -i "s|$current_sha_linux_x64|$sha_linux_x64|g" ./Formula/v2raya-unstable.rb
    sed -i "s|$current_url_darwin_x64|$url_darwin_x64|g" ./Formula/v2raya-unstable.rb
    curl -sL "$url_darwin_x64" -o v2raya_darwin_x64.zip; sha_darwin_x64=$(sha256sum v2raya_darwin_x64.zip | awk '{print $1}'); rm v2raya_darwin_x64.zip
    current_sha_darwin_x64=$(cat ./Formula/v2raya-unstable.rb | grep 'sha_macos_x64 =' | awk -F '"' '{print $2}')
    sed -i "s|$current_sha_darwin_x64|$sha_darwin_x64|g" ./Formula/v2raya-unstable.rb
    sed -i "s|$current_url_darwin_arm64|$url_darwin_arm64|g" ./Formula/v2raya-unstable.rb
    curl -sL "$url_darwin_arm64" -o v2raya_darwin_arm64.zip; sha_darwin_arm64=$(sha256sum v2raya_darwin_arm64.zip | awk '{print $1}'); rm v2raya_darwin_arm64.zip
    current_sha_darwin_arm64=$(cat ./Formula/v2raya-unstable.rb | grep 'sha_macos_arm64 =' | awk -F '"' '{print $2}')
    sed -i "s|$current_sha_darwin_arm64|$sha_darwin_arm64|g" ./Formula/v2raya-unstable.rb
    sed -i "s|$current_version|$latest_version|g" ./Formula/v2raya-unstable.rb
    git commit ./Formula/v2raya-unstable.rb -m "v2raya-unstable: update to $latest_version"
else
    echo "Nothing to do, you have the latest version of v2raya-unstable."
fi
