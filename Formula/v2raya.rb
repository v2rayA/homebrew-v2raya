class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.4.7"
    
    $v2rayA_version = "2.2.4.7"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.7/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "3afdb32e69e8f816de69f4f5c1ee63be30215b005eea6b859f1a95e9b863446f"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.7/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "96d4cc2120cebbcd47027be45ac21ed8565d1d39f2ba3b15d0e0fa399e6f7590"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.7/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "9c536917c9c45075d6ad8a7fcc138481740b9f779c8a05260485c237568d7cd8"

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
