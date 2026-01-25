class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.7.5"
    
    $v2rayA_version = "2.2.7.5"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.5/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "9027bfa6e58f9257623c772f07b52c4a00449581a271cfa4eb2e1009c996c223"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.5/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "7a628d8359e8019a532515f71fb6ec7f6ac01b0ada7e0b18f92b835dbf841b90"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.5/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "77e0d0acae4587c371e800a752ab20cc7784bff2088c21f0537cb85786052e05"

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
