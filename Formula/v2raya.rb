class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.7.1"
    
    $v2rayA_version = "2.2.7.1"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.1/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "01698c9031710a3266966968d6ec2b68d59cdf839c50cffc140fdecc58509d21"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.1/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "aa4f4a838eee3e1e20a1d7d4ea1a9fe6ffda788c93f23a7bc83d8056edf01986"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.7.1/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "b52988d670a34f6f150af4ab6f8f9f991c2590f7067fd13a6cb19c6f04664d74"

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
