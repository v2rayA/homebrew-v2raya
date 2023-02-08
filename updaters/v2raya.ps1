$Version_Latest = (Invoke-RestMethod "https://api.github.com/repos/v2rayA/homebrew-v2raya/releases/latest").tag_name
$Version_Current = Get-Content "./Formula/v2raya.rb" | Select-String v2rayA_version | ForEach-Object { ([string]$_).split('"')[1]}

if ([String]::IsNullOrEmpty($Version_Latest)) {
    Write-Output "GitHub API rate limit exceeded, please try again later."
    exit
}

If ($Version_Current -eq $Version_Latest) {
    Write-Output "Nothing to do, you have the latest version of v2raya."
}else {
    $New_SHA256_Darwin_A64 = Invoke-RestMethod "https://github.com/v2rayA/homebrew-v2raya/releases/download/$Version_Latest/v2raya-aarch64-macos.zip.sha256.txt" | ForEach-Object { ([string]$_).split('  ')[0]}
    $New_SHA256_Darwin_x64 = Invoke-RestMethod "https://github.com/v2rayA/homebrew-v2raya/releases/download/$Version_Latest/v2raya-x86_64-macos.zip.sha256.txt" | ForEach-Object { ([string]$_).split('  ')[0]}
    $New_SHA256_Linux_x64 = Invoke-RestMethod "https://github.com/v2rayA/homebrew-v2raya/releases/download/$Version_Latest/v2raya-x86_64-linux.zip.sha256.txt" | ForEach-Object { ([string]$_).split('  ')[0]}
    $Old_SHA256_Darwin_A64 = Get-Content ./Formula/v2raya.rb | Select-String 'sha_macos_arm64 ='| ForEach-Object { ([string]$_).split('"')[1]} 
    $Old_SHA256_Darwin_x64 = Get-Content ./Formula/v2raya.rb | Select-String 'sha_macos_x64 =' | ForEach-Object { ([string]$_).split('"')[1]} 
    $Old_SHA256_Linux_x64 = Get-Content ./Formula/v2raya.rb | Select-String 'sha_linux_x64 =' | ForEach-Object { ([string]$_).split('"')[1]}
    (Get-Content -Path "./Formula/v2raya.rb") -replace $Old_SHA256_Darwin_A64, $New_SHA256_Darwin_A64 | Out-File "./Formula/v2raya.rb"
    (Get-Content -Path "./Formula/v2raya.rb") -replace $Old_SHA256_Darwin_x64, $New_SHA256_Darwin_x64 | Out-File "./Formula/v2raya.rb"
    (Get-Content -Path "./Formula/v2raya.rb") -replace $Old_SHA256_Linux_x64, $New_SHA256_Linux_x64 | Out-File "./Formula/v2raya.rb"
    (Get-Content -Path "./Formula/v2raya.rb") -replace $Version_Current, $Version_Latest | Out-File "./Formula/v2raya.rb"
    git commit "./Formula/v2raya.rb" -m "v2rayA: update to version $Version_Latest"
}

# $version_Loyalsoldier_latest = ((Invoke-WebRequest "https://api.github.com/repos/Loyalsoldier/v2ray-rules-dat/releases/latest" | ConvertFrom-Json ).tag_name)
# $version_Loyalsoldier_current = Get-Content "./Formula/v2raya.rb" | Select-String 'Loyalsoldier_version' | ForEach-Object { ([string]$_).split('"')[1]}
