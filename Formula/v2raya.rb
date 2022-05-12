class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "1.5.7"
 
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.7/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "A05EB77538B989841B53421B9B8F5B5607D899A55B95DDC5E1F7942CC88AA000"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.7/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "596F5CC2954B83936B525ABC0020709BF5545596914594ECB58C0D05DAC0A1D3"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.7/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "EA4A62E6178BF2333FCD45DDDE52B2F61431D097ABDA6076A5E5C66CF2427961"
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

    depends_on "v2ray"

    def install
      bin.install "v2raya"
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray", V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
