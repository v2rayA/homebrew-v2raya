$Latest_Version = curl -s "https://api.github.com/repos/v2fly/v2ray-core/releases/latest" | sed 'y/,/\n/'  | grep 'tag_name' | awk -F '"' '{print $4}' | sed s/v//
$Current_Version = Get-Content "./Formula/v2ray5.rb" | Select-String version | ForEach-Object { ([string]$_).split('"')[1] }

if ($Latest_Version -eq $Current_Version) {
    Write-Output "Nothing to do, you have the latest version of v2ray5."
}
else {
    $Current_Linux64_Hash = Get-Content ./Formula/v2ray5.rb | Select-String 'sha_linux_x64 =' | ForEach-Object { ([string]$_).split('"')[1] }
    $Current_macOS_x64Hash = Get-Content ./Formula/v2ray5.rb | Select-String 'sha_macos_x64 =' | ForEach-Object { ([string]$_).split('"')[1] }
    $Current_macOS_arm64Hash = Get-Content ./Formula/v2ray5.rb | Select-String 'sha_macos_arm64 =' | ForEach-Object { ([string]$_).split('"')[1] }
    $Latest_Linux64_Hash = curl -Ls "https://github.com/v2fly/v2ray-core/releases/download/v$Latest_Version/v2ray-linux-64.zip.dgst" | grep SHA256 | awk -F ' ' '{print $2}'
    $Latest_macOS_x64Hash = curl -Ls "https://github.com/v2fly/v2ray-core/releases/download/v$Latest_Version/v2ray-macos-64.zip.dgst" | grep SHA256 | awk -F ' ' '{print $2}'
    $Latest_macOS_arm64Hash = curl -Ls "https://github.com/v2fly/v2ray-core/releases/download/v$Latest_Version/v2ray-macos-arm64-v8a.zip.dgst" | grep SHA256 | awk -F ' ' '{print $2}'
    (Get-Content -Path "./Formula/v2ray5.rb") -replace $Current_Linux64_Hash, $Latest_Linux64_Hash | Out-File "./Formula/v2ray5.rb"
    (Get-Content -Path "./Formula/v2ray5.rb") -replace $Current_macOS_x64Hash, $Latest_macOS_x64Hash | Out-File "./Formula/v2ray5.rb"
    (Get-Content -Path "./Formula/v2ray5.rb") -replace $Current_macOS_arm64Hash, $Latest_macOS_arm64Hash | Out-File "./Formula/v2ray5.rb"
    (Get-Content -Path "./Formula/v2ray5.rb") -replace $Current_Version, $Latest_Version | Out-File "./Formula/v2ray5.rb"
    git commit -a -m "v2ray5: update to version $Latest_Version"
}