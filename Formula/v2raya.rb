class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.4.19"

    $v2rayA_version = "2.4.19"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.19/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "5d82d0769c961d77bc84047965f267766fedddd0a60b250051b77b40d0503ab4"
    $url_linux_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.19/v2raya-arm64-linux.zip"
    $sha_linux_arm64 = "0dc93ac697d73553586e07ff3e51b72aa4558882ba3242f44b9e58563e462f8a"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.19/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "69383ef35f3cc31799a82ed3ac628eaa753217b3590ec0cbb3b670853b3ab3ed"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.19/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "3d76dcebe2ba502244d3c000fac748fecd79484fcb4d717221ed048a7597d8e6"

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
