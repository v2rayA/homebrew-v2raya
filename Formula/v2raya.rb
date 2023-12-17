class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.4.6"
    
    $v2rayA_version = "2.2.4.6"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.6/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "736d6d2eaa8a470d981c5cb4c400657d5acd7daa6660966058d2a9e09a369cd8"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.6/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "6c0d1e024cf432f069e17f9b18a8393fddb08aadb25f417009cb7dc9c52391e5"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.6/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "f25fef7a5e7f68325cbe8853e1278abb928f0c3808887567a87c1852e8f8c2a1"

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
