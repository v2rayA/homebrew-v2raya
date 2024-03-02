class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.5.1"
    
    $v2rayA_version = "2.2.5.1"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.1/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "82d69a5145b7b5dc708cb01b028d847b1fee0b9ffb1642a26b0db0c2a0eab62b"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.1/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "44036691c36409c5113a2f4a4ce561be7458ed18b5418c491f7f7c8d5621b11a"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.1/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "27b77a4dd88d14a381bbc62601b6dcf4749dc87efb6e2346d5ab0dd443475055"

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
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
