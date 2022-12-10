$Env:PATH += ':/home/linuxbrew/.linuxbrew/opt/node@16/bin' 

Function Compress-File([ValidateScript({Test-Path $_})][string]$File){
 
    $srcFile = Get-Item -Path $File
    $newFileName = "$($srcFile.FullName).gz"
 
    try
    {
        $srcFileStream = New-Object System.IO.FileStream($srcFile.FullName,([IO.FileMode]::Open),([IO.FileAccess]::Read),([IO.FileShare]::Read))
        $dstFileStream = New-Object System.IO.FileStream($newFileName,([IO.FileMode]::Create),([IO.FileAccess]::Write),([IO.FileShare]::None))
        $gzip = New-Object System.IO.Compression.GZipStream($dstFileStream,[System.IO.Compression.CompressionMode]::Compress)
        $srcFileStream.CopyTo($gzip)
    } 
    catch
    {
        Write-Host "$_.Exception.Message" -ForegroundColor Red
    }
    finally
    {
        $gzip.Dispose()
        $srcFileStream.Dispose()
        $dstFileStream.Dispose()
    }
}

$v2raya_latest = ((Invoke-WebRequest -Uri 'https://api.github.com/repos/v2raya/v2raya/releases/latest' | ConvertFrom-Json).tag_name).Split("v")[1]
$v2raya_url = 'https://github.com/v2rayA/v2rayA/archive/refs/tags/' + 'v' + $v2raya_latest + '.tar.gz'
$v2raya_source_path = 'v2rayA-' + $v2raya_latest

Write-Output $v2raya_latest; Write-Output $v2raya_source_path; Write-Output $v2raya_url
Invoke-WebRequest -Uri $v2raya_url -OutFile 'v2raya_latest.tar.gz'
tar -xzf ./v2raya_latest.tar.gz
Set-Location $v2raya_source_path
# ${env:NODE_OPTIONS} = "--openssl-legacy-provider"

pwsh -c "Set-Location ./gui ;yarn; yarn build"
Get-ChildItem "./web" -recurse |Where-Object{$_.PSIsContainer -eq $False}|ForEach-Object -Process{
    if($_.Extension -ne ".png" -and $_.Extension -ne ".gz" -and $_.Name -ne "index.html"){
        Compress-File($_.FullName)
        Remove-Item -Path $_.FullName
    }
}

New-Item -ItemType Directory -Path ./ -Name "v2raya-x86_64-linux"
New-Item -ItemType Directory -Path ./ -Name "v2raya-x86_64-macos"
New-Item -ItemType Directory -Path ./ -Name "v2raya-aarch64-macos"

Copy-Item -Path ./web -Destination ./service/server/router/ -Force -Recurse
Set-Location ./service
$env:CGO_ENABLED = "0"
$build_flags = '-X github.com/v2rayA/v2rayA/conf.Version=' + $v2raya_latest + '-homebrew' + ' -s -w'
$env:GOARCH = "amd64"; $env:GOOS = "linux"; go build -ldflags $build_flags -o '../v2raya-x86_64-linux/v2raya'
$env:GOARCH = "amd64"; $env:GOOS = "darwin"; go build -ldflags $build_flags -o '../v2raya-x86_64-macos/v2raya'
$env:GOARCH = "arm64"; $env:GOOS = "darwin"; go build -ldflags $build_flags -o '../v2raya-aarch64-macos/v2raya'
Set-Location ../

Compress-Archive -Path "./v2raya-x86_64-linux/*" -DestinationPath "../v2raya-x86_64-linux.zip"
Get-FileHash "../v2raya-x86_64-linux.zip" | Select-Object Hash | ForEach-Object { ([string]$_.Hash) } | Out-File -Path "../v2raya-x86_64-linux-sha256.txt"

Compress-Archive -Path "./v2raya-x86_64-macos/*" -DestinationPath "../v2raya-x86_64-macos.zip"
Get-FileHash "../v2raya-x86_64-macos.zip" | Select-Object Hash | ForEach-Object { ([string]$_.Hash) } | Out-File -Path "../v2raya-x86_64-macos-sha256.txt"

Compress-Archive -Path "./v2raya-aarch64-macos/*" -DestinationPath "../v2raya-aarch64-macos.zip"
Get-FileHash "../v2raya-aarch64-macos.zip" | Select-Object Hash | ForEach-Object { ([string]$_.Hash) } | Out-File -Path "../v2raya-aarch64-macos-sha256.txt"
