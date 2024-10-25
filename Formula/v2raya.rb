class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.6.1"
    
    $v2rayA_version = "2.2.6.1"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.1/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "c299a34710c9186b3b6eebda7b85c0a0fc02f3ccf023a1b07608ff4d8759aed1"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.1/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "72a38ab8abb5462a1169d927ab7f44a3470841087190d6267da8985c6204ffcd"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.1/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "eef129762c05340ef4012632b244450d0711d21b9b82ff8577d0844af51363f6"

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
