#Update v2raya.rb
$Url = 'https://api.github.com/repos/v2rayA/homebrew-v2raya/releases/latest'
$Version_Latest = Invoke-WebRequest -Uri $Url |  ConvertFrom-Json | Select-Object tag_name | ForEach-Object { ([string]$_.'tag_name') }
$Version_Current = Get-Content "./Formula/v2raya.rb" | Select-String version | ForEach-Object { ([string]$_).split('"')[1]}

git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
git config --local user.name "github-actions[bot]"

If ($Version_Current -eq $Version_Latest) {
    Write-Output "Nothing to do, you have the latest version of v2raya."
}else {
    $New_SHA256_Darwin_A64 = curl -sL "https://github.com/v2rayA/homebrew-v2raya/releases/download/$Version_Latest/v2raya-aarch64-macos-sha256.txt"
    $New_SHA256_Darwin_x64 = curl -sL "https://github.com/v2rayA/homebrew-v2raya/releases/download/$Version_Latest/v2raya-x86_64-macos-sha256.txt"
    $New_SHA256_Linux_x64 = curl -sL "https://github.com/v2rayA/homebrew-v2raya/releases/download/$Version_Latest/v2raya-x86_64-linux-sha256.txt"
    $Old_SHA256_Darwin_A64 = Get-Content ./Formula/v2raya.rb | Select-String 'sha_macos_arm64 ='| ForEach-Object { ([string]$_).split('"')[1]} 
    $Old_SHA256_Darwin_x64 = Get-Content ./Formula/v2raya.rb | Select-String 'sha_macos_x64 =' | ForEach-Object { ([string]$_).split('"')[1]} 
    $Old_SHA256_Linux_x64 = Get-Content ./Formula/v2raya.rb | Select-String 'sha_linux_x64 =' | ForEach-Object { ([string]$_).split('"')[1]}
    (Get-Content -Path "./Formula/v2raya.rb") -replace $Old_SHA256_Darwin_A64, $New_SHA256_Darwin_A64 | Out-File "./Formula/v2raya.rb"
    (Get-Content -Path "./Formula/v2raya.rb") -replace $Old_SHA256_Darwin_x64, $New_SHA256_Darwin_x64 | Out-File "./Formula/v2raya.rb"
    (Get-Content -Path "./Formula/v2raya.rb") -replace $Old_SHA256_Linux_x64, $New_SHA256_Linux_x64 | Out-File "./Formula/v2raya.rb"
    (Get-Content -Path "./Formula/v2raya.rb") -replace $Version_Current, $Version_Latest | Out-File "./Formula/v2raya.rb"
    git commit "./Formula/v2raya.rb" -m "Update v2rayA to $Version_Latest"
}

#Update v2raya-git.rb
$Latest_Commit_ID = (((Invoke-WebRequest -Uri "https://api.github.com/repos/v2rayA/v2rayA/commits/feat_v5" | ConvertFrom-Json).commit).url).Split("/")[8]
$Latest_Source_Url = "https://github.com/v2rayA/v2rayA/archive/$Latest_Commit_ID.zip"

Invoke-WebRequest -Uri $Latest_Source_Url -OutFile "./v2rayA-$Latest_Commit_ID"
$Latest_File_Hash = (Get-FileHash "./v2rayA-$Latest_Commit_ID").hash

$Current_Source_Url = Get-Content -Path "./Formula/v2raya-git.rb" | Select-String "url " | ForEach-Object { ([string]$_).split('"')[1]}
$Current_File_Hash = Get-Content -Path "./Formula/v2raya-git.rb" | Select-String "sha256 " | ForEach-Object { ([string]$_).split('"')[1]}

$Latest_Version_Date = ((((Invoke-WebRequest -Uri "https://api.github.com/repos/v2rayA/v2rayA/commits/feat_v5" | ConvertFrom-Json)."commit")."author") | ConvertTo-Json | ForEach-Object { ([string]$_).split('"')[11]} | ForEach-Object { ([string]$_).split('T')[0]}) -Replace "-",""
$Latest_Version = $Latest_Version_Date + $(($Latest_Commit_ID)|cut -b 1-6)

$Current_Version = Get-Content -Path "./Formula/v2raya-git.rb" | Select-String "version " | ForEach-Object { ([string]$_).split('"')[1]}

if ($Current_Version -eq $Latest_Version) {
    Write-Output "Nothing to do, you have the latest version of v2raya-git."
}else{
    Get-Content -Path "./Formula/v2raya-git.rb" | -replace $Current_Source_Url, $Latest_Source_Url | Out-File "./Formula/v2raya-git.rb"
    Get-Content -Path "./Formula/v2raya-git.rb" | -replace $Current_Version, $Latest_Version | Out-File "./Formula/v2raya-git.rb"
    Get-Content -Path "./Formula/v2raya-git.rb" | -replace $Current_File_Hash, $Latest_File_Hash | Out-File "./Formula/v2raya-git.rb"
    git commit "./Formula/v2raya-git.rb" -m "Update v2rayA-git to $Latest_Version"
}