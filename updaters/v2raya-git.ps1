$Latest_Commit_ID = (((Invoke-WebRequest -Uri "https://api.github.com/repos/v2rayA/v2rayA/commits/feat_v5" | ConvertFrom-Json).commit).url).Split("/")[8]
$Latest_Source_Url = "https://github.com/v2rayA/v2rayA/archive/$Latest_Commit_ID.zip"

Invoke-WebRequest -Uri $Latest_Source_Url -OutFile "./v2rayA-$Latest_Commit_ID"
$Latest_File_Hash = (Get-FileHash "./v2rayA-$Latest_Commit_ID").hash

$Current_Source_Url = Get-Content -Path "./Formula/v2raya-git.rb" | Select-String "url " | ForEach-Object { ([string]$_).split('"')[1]}
$Current_File_Hash = Get-Content -Path "./Formula/v2raya-git.rb" | Select-String "sha256 " | ForEach-Object { ([string]$_).split('"')[1]}

$Latest_Version_Date = ((((Invoke-WebRequest -Uri "https://api.github.com/repos/v2rayA/v2rayA/commits/feat_v5" | ConvertFrom-Json)."commit")."author") | ConvertTo-Json | ForEach-Object { ([string]$_).split('"')[11]} | ForEach-Object { ([string]$_).split('T')[0]}) -Replace "-",""
$Latest_Version = $Latest_Version_Date + "." + $(($Latest_Commit_ID)|cut -b 1-6)

$Current_Version = Get-Content -Path "./Formula/v2raya-git.rb" | Select-String "version " | ForEach-Object { ([string]$_).split('"')[1]}

if ($Current_Version -eq $Latest_Version) {
    Write-Output "Nothing to do, you have the latest version of v2raya-git."
}else{
    (Get-Content -Path "./Formula/v2raya-git.rb") -replace $Current_Source_Url, $Latest_Source_Url | Out-File "./Formula/v2raya-git.rb"
    (Get-Content -Path "./Formula/v2raya-git.rb") -replace $Current_Version, $Latest_Version | Out-File "./Formula/v2raya-git.rb"
    (Get-Content -Path "./Formula/v2raya-git.rb") -replace $Current_File_Hash, $Latest_File_Hash | Out-File "./Formula/v2raya-git.rb"
    git commit "./Formula/v2raya-git.rb" -m "v2rayA-git: update to version $Latest_Version"
}