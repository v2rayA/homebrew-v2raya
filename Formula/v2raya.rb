class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.1.0"
    
    $v2rayA_version = "2.1.0"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.0/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "8f59ae070cb149620eff9a653b252c376a8bbe368908084e7fb63388143a29fa"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.0/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "bcab10cd942d4c40d9f30deb26b18ce9d8e4b3aba0b02e4001af93b18c42ed34"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.0/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "b20ab03c941696fddb0e422b0df589deb118a2eddc4127731275a97849b9bc1e"

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
