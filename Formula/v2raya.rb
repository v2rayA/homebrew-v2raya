class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "1.5.9.1698.1"
 
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.9.1698.1/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "339159430E3EFC9CA1AA9838901E1F1E82753B1EFDD9BF233613526F42556F23"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.9.1698.1/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "F040A91DFC2C0779042BB2FA455B82F0202B43E5B2F79CBF4B5E4303F17CD24E"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.9.1698.1/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "77F571C007D039AD9E00766906707C933D78577BA625648EF2A229A72A77C399"
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
