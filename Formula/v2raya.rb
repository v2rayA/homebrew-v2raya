class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.7.4"
    
    $v2rayA_version = "2.2.7.4"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.4/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "69f61726fd5fa29c8720033b7748b260c8de1408e9d400688772724de7ca7a42"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.4/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "d24152a0bac58a2572e1f6677e75484b8940151f2a58bc9eb7b27702f185ba60"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.4/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "db789e90c8288ec462b5b6b8107086553bfe453d7dcae7fa5cf99cba530f65e6"

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
