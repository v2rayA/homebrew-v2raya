class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.7.3"
    
    $v2rayA_version = "2.2.7.3"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.3/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "69ce4ee1bbab6dd60ffc5e4848841b66bd7ca93bb312fa133de868b12dd6dd1d"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.3/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "9c2000959869ed2d3f18f640aa663572985240143164557b2c1de3ea9e59dd87"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.3/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "423faa0445d2c6e2adbbd70574f1387e1348a90c2d67e59bcd95c12a9b9db89b"

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
