class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.1"
 
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "C60FDE2BCA22D22BEE3607648B02E64F113587051BD784F684061FC4AB93990C"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "F0B0E73BFD1DA69F96791A9163EF178C6426FBE3C23EEA8BF74275CECF74198A"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "CACD0DECEE427DA4DB4B29CED111484C3483FF67D673FFD09E32D9BCEB95E5E7"
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
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray5", V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2ray5"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
