#!/bin/bash

set -e

# v2rayA_latest_tag=$(curl -s https://api.github.com/repos/v2rayA/v2rayA/tags | jq -r ".[]" |  jq -r '.name' | awk 'NR==1 {print; exit}' | awk -F 'v' '{print $2}')
v2rayA_build_tag='2.0.4'
v2rayA_source_url='https://github.com/v2rayA/v2rayA/archive/refs/tags/''v'"$v2rayA_build_tag"'.tar.gz'

curl -L -o v2rayA.tar.gz $v2rayA_source_url
tar -xzf v2rayA.tar.gz

current_dir="$(pwd)"
build_flags='-X github.com/v2rayA/v2rayA/conf.Version='"v$v2rayA_build_tag-brew"' -s -w'

export CGO_ENABLED="0"

mkdir $current_dir/v2raya-x86_64-linux/
mkdir $current_dir/v2raya-x86_64-macos/
mkdir $current_dir/v2raya-aarch64-macos/

cd v2rayA-$v2rayA_latest_tag
cd ./gui && yarn && yarn build
cd ..
cp -r ./web ./service/server/router/
cd ./service
GOARCH="amd64" GOOS="linux" go build -ldflags "$build_flags" -o $current_dir/v2raya-x86_64-linux/v2raya
GOARCH="amd64" GOOS="darwin" go build -ldflags "$build_flags" -o $current_dir/v2raya-x86_64-macos/v2raya
GOARCH="arm64" GOOS="darwin" go build -ldflags "$build_flags" -o $current_dir/v2raya-aarch64-macos/v2raya

cd $current_dir
zip -r v2raya-x86_64-linux.zip ./v2raya-x86_64-linux/*
zip -r v2raya-x86_64-macos.zip ./v2raya-x86_64-macos/*
zip -r v2raya-aarch64-macos.zip ./v2raya-aarch64-macos/*

for i in v2raya-x86_64-linux.zip v2raya-x86_64-macos.zip v2raya-aarch64-macos.zip; do
  shasum -a 256 $i > $i.sha256.txt
done
