class V2ray5 < Formula
    desc "v2ray core from Project V"
    homepage "https://www.v2fly.org/"
    license "MIT License"
    version "5.2.1"
 
    $url_linux_x64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.2.1/v2ray-linux-64.zip"
    $sha_linux_x64 = "56eb8d4727b058d10f8ff830bb0121381386b0695171767f38ba410f2613fc9a"
    $url_macos_x64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.2.1/v2ray-macos-64.zip"
    $sha_macos_x64 = "edbb0b94c05570d39a4549186927369853542649eb6b703dd432bda300c5d51a"
    $url_macos_arm64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.2.1/v2ray-macos-arm64-v8a.zip"
    $sha_macos_arm64 = "e18c17a79c4585d963395ae6ddafffb18c5d22777f7ac5938c1b40563db88d56"
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
