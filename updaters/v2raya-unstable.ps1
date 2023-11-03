$latest_run_id = ((Invoke-RestMethod "https://api.github.com/repos/v2rayA/v2rayA/actions/workflows/release_main.yml/runs").workflow_runs).jobs_url | Select-Object -First 1 | ForEach-Object { ([string]$_).split('/')[8]}
$latest_unstable_version = ((Invoke-RestMethod "https://api.github.com/repos/v2rayA/v2rayA/actions/runs/$latest_run_id/artifacts").artifacts).name | Select-Object -First 1 | ForEach-Object { ([string]$_).split('-')[1]} | ForEach-Object { ([string]$_).split('.pkg')[0]}
$current_unstable_version = Get-Content ./Formula/v2raya-unstable.rb | Select-String 'v2raya_version' | ForEach-Object { ([string]$_).split('"')[1]}
if ($current_unstable_version -eq $latest_unstable_version) {
    Write-Output "Nothing to do, you have the latest version of v2raya-unstable."
}else{
    $latest_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/$latest_run_id/v2raya_linux_x64_unstable-$latest_unstable_version.zip"
    Write-Output $latest_linux_x64
    $latest_darwin_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/$latest_run_id/v2raya_darwin_x64_unstable-$latest_unstable_version.zip"
    Write-Output $latest_darwin_x64
    $latest_darwin_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/$latest_run_id/v2raya_darwin_arm64_unstable-$latest_unstable_version.zip"
    Write-Output $latest_darwin_arm64
    $latest_linux_x64, $latest_darwin_x64, $latest_darwin_arm64 | ForEach-Object {
        $filename = $_.Split('/')[-1]
        $filepath = "./$filename"
        if (Test-Path $filepath) {
            Write-Output "$filepath already exists."
        }else{
            Invoke-WebRequest -Uri $_ -OutFile $filepath
        }
    }
    $sha256_linux_x64 = ((Get-FileHash "./v2raya_linux_x64_unstable-$latest_unstable_version.zip" -Algorithm SHA256).Hash).ToLower()
    Write-Output $sha256_linux_x64
    $sha256_darwin_x64 = ((Get-FileHash "./v2raya_darwin_x64_unstable-$latest_unstable_version.zip" -Algorithm SHA256).Hash).ToLower()
    Write-Output $sha256_darwin_x64
    $sha256_darwin_arm64 = ((Get-FileHash "./v2raya_darwin_arm64_unstable-$latest_unstable_version.zip" -Algorithm SHA256).Hash).ToLower()
    Write-Output $sha256_darwin_arm64
    Get-Content "./templates/v2raya-unstable.rb" | ForEach-Object { $_ -replace 'TheRealVersion', $latest_unstable_version } | ForEach-Object { $_ -replace 'RealUrl_Linux_x64', $latest_linux_x64 } | ForEach-Object { $_ -replace 'RealUrl_MacOS_x64', $latest_darwin_x64 } | ForEach-Object { $_ -replace 'RealUrl_MacOS_arm64', $latest_darwin_arm64 } | ForEach-Object { $_ -replace 'TheRealVersion', $latest_unstable_version } | ForEach-Object { $_ -replace 'RealSha256_Linux_x64', $sha256_linux_x64 } | ForEach-Object { $_ -replace 'RealSha256_MacOS_x64', $sha256_darwin_x64 } | ForEach-Object { $_ -replace 'RealSha256_MacOS_arm64', $sha256_darwin_arm64 } | Set-Content "./Formula/v2raya-unstable.rb"
    Remove-Item -Path "v2raya_*.zip" -Force -Recurse
    git commit "./Formula/v2raya-unstable.rb" -m "v2raya-unstable: update to $latest_unstable_version"
}
