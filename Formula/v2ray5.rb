class V2ray5 < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://www.v2fly.org/"
    license "MIT License"
    version "5.1.0"
 
    $url_linux_x64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-linux-64.zip"
    $sha_linux_x64 = "e670334a1734b37361f5a1f12d79e989944b0f9556322f1ae710c2db16528e6a"
    $url_macos_x64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-macos-64.zip"
    $sha_macos_x64 = "fe649ebe10d507d0f04db3eeaccb6363cffac1fc42e517d0e10f3fc16c6ef5cd"
    $url_macos_arm64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-macos-arm64-v8a.zip"
    $sha_macos_arm64 = "a916c2b1a041ad5771fa0153ceed24260e6b9e07e5f946caf80b949c699f44f4"
    if OS.linux?
      url $url_linux_x64
      sha256 $sha_linux_x64
    elsif Hardware::CPU.intel?
      url $url_macos_x64
      sha256 $sha_macos_x64
      else
      url $url_macos_arm64
      sha256 $sha_macos_arm64
    end

    def install
      bin.install "v2ray" => "v2ray5"
      pkgetc.install "config.json"
      pkgshare.install "geoip.dat"
      pkgshare.install "geosite.dat"
      pkgshare.install "geoip-only-cn-private.dat"
    end

    service do
      environment_variables V2RAY_LOCATION_ASSET: "#{HOMEBREW_PREFIX}/opt/v2ray5/share"
      run [bin/"v2ray5", "run", "-config", etc/"v2ray5/config.json"]
      keep_alive true
    end
end
