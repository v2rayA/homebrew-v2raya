class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.4.16"

    $v2rayA_version = "2.4.16"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.16/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "dad3349d9f01b5e04c5a1f54beb4c4b875e706b0e6f4c7527c9379f1bb37cb27"
    $url_linux_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.16/v2raya-arm64-linux.zip"
    $sha_linux_arm64 = "fa42ad9516e99be3a8fd18e0acc23e023277fc418388c491d1ba7a5e4961c556"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.16/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "7f7bb746516af992e1f882d7ee977ff39682df74821e94c718359e5ccdca6802"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.16/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "5ab5a3b49f4a732db898996dc02fee15d4814dcac62b40f7bcde896455251822"

    depends_on "v2ray-rules-dat"

    if OS.linux?
      if Hardware::CPU.arm?
        url $url_linux_arm64
        sha256 $sha_linux_arm64
      else
        url $url_linux_x64
        sha256 $sha_linux_x64
      end
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
      File.symlink(rules_dat.opt_pkgshare/"geosite.dat", share/"v2raya"/"geosite.dat")
      File.symlink(rules_dat.opt_pkgshare/"geoip.dat", share/"v2raya"/"geoip.dat")
      puts "If you forget your password, stop running v2raya, then run `v2raya --lite --reset-password` to reset password."
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
