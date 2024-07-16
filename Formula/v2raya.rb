class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.5.8"
    
    $v2rayA_version = "2.2.5.8"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.8/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "5d088eef9830be41fcf4c23b5a0dda6643e2ea9799c653c761153cfd8b42ee20"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.8/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "0558f153f08f3ef568f7d4165d17367f64ca0a96afdf0817b5b4474b4e9cf7ef"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.8/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "8dff079d93fb024421d1292f0bb8f2bb43d55225b7b52e71c15b1a566163f433"

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
