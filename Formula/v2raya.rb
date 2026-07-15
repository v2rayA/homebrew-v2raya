class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.4.6"
    
    $v2rayA_version = "2.4.6"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.6/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "16b8f3cdb3710707523946011663a2ca7585e4535fc6adb51f905d6a957067ae"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.6/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "a3008fd94c3675d1acadaec390fb4abf78604f71e8b5524217b30e6b7f4c2c51"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.6/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "b7ced1407dd73b8745836ca30052d9369a834cdc8e10c4b985b63c1e16beacc2"

    depends_on "v2ray-rules-dat"

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

    def install
      bin.install "v2raya"
      bin.install "v2raya_core"
      rules_dat = Formula["v2ray-rules-dat"]
      mkdir_p share/"v2raya"
      share/"v2raya".install_symlink(rules_dat.opt_pkgshare/"geosite.dat")
      share/"v2raya".install_symlink(rules_dat.opt_pkgshare/"geoip.dat")
      puts "If you forget your password, stop running v2raya, then run `v2raya --lite --reset-password` to reset password."
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
