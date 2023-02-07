class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.1-1"
 
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-1/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "2D4B5877ABAF015A5C5E25A5DB08B3DE23B16294B84CAFBE70174C35F507B11F"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-1/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "9B0649088438AB685D55B0C1C4B0BCF5E11E359DC38E7473D7A8ED2FA4D76DB1"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-1/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "76A1BF94F8E7A3803D3A6B8799484D1E162D947D5320DAEE01C5537CA7BA1232"
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

    depends_on "v2ray5"

    def install
      bin.install "v2raya"
      pkgshare.install "geoip.dat"
      pkgshare.install "geosite.dat"
      pkgshare.install "geoip-only-cn-private.dat"
      pkgshare.install "LoyalsoldierSite.dat"
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray5", V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
