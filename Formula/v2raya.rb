class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.6.4"
    
    $v2rayA_version = "2.2.6.4"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.4/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "6d3bfb10e57ca02da6d89cc3932ac2420221cf135d88da2391762c1a523b8a6e"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.4/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "233b2a3d577bdb3c717a4b0385d27e60aa659907314d697b2001d6a17efdca76"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.4/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "02bef485e0ffe10c9ed54b08c2dc5c7f7d371563303426fdc7ef52af53841844"

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
