class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.1.1"
    
    $v2rayA_version = "2.1.1"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.1/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "555ad9693129adfd9475d3b46f53b6764a0bceaf2dfe930e4db7fb55f11e8581"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.1/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "7657f3b434b9c5e2750272b240fbb9385e0024287d6cb0b74bd3c2fdcd074682"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.1/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "a72c8d99317ece0a1eeb2db82723d97a686cd8f4e4b2e43780ccda6578d62fcb"

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
