class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.6.7"
    
    $v2rayA_version = "2.2.6.7"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.7/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "0bef491639ff6d35f166a35d149600f0aa7c1e9c3c1d850d6f842bf32a72183b"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.7/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "6865a6e83abf5e0904b9ab416e8ed0b7b4d000ae6dc9da89f471ae8b258b6d32"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.7/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "dcbe896506c91da90368305a9a296ffa41c729ed553b47f51bda5192443e6baf"

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
