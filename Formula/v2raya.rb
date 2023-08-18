class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.1.3"
    
    $v2rayA_version = "2.1.3"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.3/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "e858342841e262afea3757519062aee99f3417b435609eaf7b998408db3d641a"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.3/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "d4de7521eec41093bba3ffe8e1ce3a99b0ca8e63edcc0a9ba2d0798733122103"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.1.3/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "a4c3802341be946e266422bace7b442394f198730065f84eebd18edcf3054060"

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
