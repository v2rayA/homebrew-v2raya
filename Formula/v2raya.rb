class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.4.20"

    $v2rayA_version = "2.4.20"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.20/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "e602e25a0c5ff428f4da6583ef5c0ef02901750a1011b62542de2a2ecc7fad24"
    $url_linux_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.20/v2raya-arm64-linux.zip"
    $sha_linux_arm64 = "ab3f200a01a7ab926460b475efd6ec98590d4dc53c3fe2d298c32a487365f409"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.20/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "55f830fc51f2aeb235cb36e9b65da9fc680c74b9848c82f3848732f1cdde3c3b"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.4.20/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "d1cd63663a254d21177dfcce521234c7908eb1f25dfe79ee9268d298013ca2d0"

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
