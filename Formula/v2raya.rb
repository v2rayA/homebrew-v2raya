class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.4.9"

    $v2rayA_version = "2.4.9"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.9/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "a20c4544c22f0cbcb6d761ed8a087b5e7e2cc2f9e3955f04628c3c66aa2e91ab"
    $url_linux_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.9/v2raya-arm64-linux.zip"
    $sha_linux_arm64 = "8287069e978fac53740a7e3225fcec3f48a4a20fa8be7eee32611c31c89daf19"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.9/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "8faff12f196262b2742aa483f792b019a25e0f72cb41e8da7961afe17f571c86"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.9/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "96876927e29e43eb1ee88c50b301fbd03a060f57cd0a25fb365c72a0cac86534"

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
