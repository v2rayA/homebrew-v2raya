#!/bin/bash

Latest_Version=$(curl https://api.github.com/repos/v2fly/v2ray-core/releases/latest | sed 'y/,/\n/'  | grep 'tag_name' | awk -F '"' '{print $4}' | sed s/v//)
Current_Version=$(cat ./Formula/v2ray5.rb | grep version | awk -F '"' '{print $2}')

Get_Latest_Hash(){
    Latest_Linux64_Hash=$(curl -L https://github.com/v2fly/v2ray-core/releases/download/v$LatestVersion/v2ray-linux-64.zip.dgst | grep SHA256 |awk -F ' ' '{print $2}')
    Latest_macOS_x64Hash=$(curl -L https://github.com/v2fly/v2ray-core/releases/download/v$LatestVersion/v2ray-macos-64.zip.dgst | grep SHA256 |awk -F ' ' '{print $2}')
    Latest_macOS_arm64Hash=$(curl -L https://github.com/v2fly/v2ray-core/releases/download/v$LatestVersion/v2ray-macos-arm64-v8a.zip.dgst | grep SHA256 |awk -F ' ' '{print $2}')
}

Get_Current_Hash(){
    Current_Linux64_Hash=$(cat ./Formula/v2ray5.rb | grep '$sha_linux_x64' | awk -F '"' '{print $2}')
    Current_macOS_x64Hash=$(cat ./Formula/v2ray5.rb | grep '$sha_macos_x64' | awk -F '"' '{print $2}')
    Current_macOS_arm64Hash=$(cat ./Formula/v2ray5.rb | grep '$sha_macos_arm64' | awk -F '"' '{print $2}')
}

if [ $Latest_Version == $Current_Version]; then
    echo "Nothing to do, you have the latest version of v2ray5."
else
    Get_Current_Hash
    Get_Latest_Hash
    cat ./Formula/v2ray5.rb | sed s/$Current_Linux64_Hash/$Latest_Linux64_Hash > ./Formula/v2ray5.rb
    cat ./Formula/v2ray5.rb | sed s/$Current_macOS_x64Hash/$Latest_macOS_x64Hash > ./Formula/v2ray5.rb
    cat ./Formula/v2ray5.rb | sed s/$Current_macOS_arm64Hash/$Latest_macOS_arm64Hash > ./Formula/v2ray5.rb
    cat ./Formula/v2ray5.rb | sed s/$Current_Version/$Latest_Version/g > ./Formula/v2ray5.rb
    git commit -a -m "v2ray5: update to version $Latest_Version"
fi