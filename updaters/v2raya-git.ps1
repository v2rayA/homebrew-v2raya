$Latest_Commit_ID = (((Invoke-RestMethod -Uri "https://api.github.com/repos/v2rayA/v2rayA/commits/feat_v5").commit).url).Split('/')[8]
$Latest_Source_Url = "https://github.com/v2rayA/v2rayA/archive/$Latest_Commit_ID.zip"

Set-PSDebug -Strict -Trace 1

Invoke-WebRequest -Uri $Latest_Source_Url -OutFile "./v2rayA-$Latest_Commit_ID"
$Latest_File_Hash = (Get-FileHash "./v2rayA-$Latest_Commit_ID").hash

$Latest_Version_Date = ((((((Invoke-RestMethod -Uri "https://api.github.com/repos/v2rayA/v2rayA/commits/feat_v5").commit).author) | ConvertTo-Json).Split('"')[11]).Split('T')[0]) -replace '-',''
$Latest_Version = $Latest_Version_Date + "." + $(($Latest_Commit_ID)|cut -b 1-7)

$Current_Version = Get-Content -Path "./Formula/v2raya-git.rb" | Select-String 'version ' | ForEach-Object { ([string]$_).split('"')[1]}

if ([String]::IsNullOrEmpty($Latest_Commit_ID)) {
    Write-Output "GitHub API rate limit exceeded, please try again later."
    exit
}

if ($Current_Version -eq $Latest_Version) {
    Write-Output "Nothing to do, you have the latest version of v2raya-git."
}else{
    (Get-Content -Path "./templates/v2raya-git.rb") -replace "Current_Source_Url", $Latest_Source_Url | Out-File "./Formula/v2raya-git.rb"
    (Get-Content -Path "./Formula/v2raya-git.rb") -replace "Current_Version", $Latest_Version | Out-File "./Formula/v2raya-git.rb"
    (Get-Content -Path "./Formula/v2raya-git.rb") -replace "Current_File_Hash", $Latest_File_Hash | Out-File "./Formula/v2raya-git.rb"
    git commit "./Formula/v2raya-git.rb" -m "v2raya-git: update to version $Latest_Version"
}

Set-PSDebug -Off