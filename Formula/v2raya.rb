class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.7.2"
    
    $v2rayA_version = "2.2.7.2"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.2/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "78117485cc260062c26152b747ffb162257a8d2d88e8b5d8ba0766da5e65a294"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.2/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "4b68abfaaeb02600d22d8b13e058bbf3c1be3203a0c2e7321c39e2ed48fe9875"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.2/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "f3f3e46222fa546acfbd266d7045bcd80d16eb9fdf8fd046b2ee861819a311a0"

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
