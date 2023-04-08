class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.5"
    
    $v2rayA_version = "2.0.5"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.5/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "ddcb64d3087c4fdd6b2ac12dd5c83e55ce948112dbe6b52998851f954e31a5b4"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.5/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "2a4be0a5c89e46a717133e5096e420fcb52cdd45088f74aaf8b11cfde52463ab"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.5/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "cad2f26bf4514c1d166d0b1f8ec253bb990af810801de482a3ec235ecc262a09"

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
