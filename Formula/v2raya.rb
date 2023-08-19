class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.0"
    
    $v2rayA_version = "2.2.0"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.0/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "27d9f54f217a0b05dd5e1aa6bc3ae8ae1c8bc47ffaaa58b1927dd78f693a08e2"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.0/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "eba6ca57db107d29edbecc54f2b8796913467529b9952201b22779e3d8e5a0ad"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.0/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "dacbe56e68e806fcfe3b2d91cf112225715fefb9e46cabaa3343eb3c39904103"

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
