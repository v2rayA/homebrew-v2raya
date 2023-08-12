class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.1.2"
    
    $v2rayA_version = "2.1.2"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.2/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "3ac2abaa3ffefa5de4dc8fdae09b43bdfb21c8bb6c587ea99d363df87bd24dce"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.2/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "f75d3d1b292fc34e214060afbee36fb903a93463e3d83612f1bb8b4e5e5a09df"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.2/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "7d32c2dfb27135d84625fe3e3205a4968ef9e674d435b1a0d1d9a7459f263cdc"

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
      puts "If you forget your password, stop running v2raya, then run `v2raya --lite --reset-password` to reset password."
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
