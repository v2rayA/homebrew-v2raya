class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.4"
    
    $v2rayA_version = "2.0.4"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.4/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "a117b48890ad62a17c60f8c198b3f1ed2e6b387557f3171a1407c3a9268caa21"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.4/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "4cd00592be119a9abe6bcc49383fddf4469cf53630608b1759a98eea42f292c1"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.4/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "00117eedb863a7dd1b34c51498de7ebdb23da9c270fe71c2e5ff46da1fbace02"

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
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
