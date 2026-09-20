class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "TheRealVersion"

    $v2rayA_version = "TheRealVersion"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/TheRealVersion/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "RealSha256_Linux_x64"
    $url_linux_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/TheRealVersion/v2raya-arm64-linux.zip"
    $sha_linux_arm64 = "RealSha256_Linux_arm64"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/TheRealVersion/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "RealSha256_MacOS_x64"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/TheRealVersion/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "RealSha256_MacOS_arm64"

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
    end

    def caveats
      <<~EOS
        The service runs as root so that the tun transparent proxy is available:
          sudo brew services start v2raya
        Without root, run it as yourself with the system proxy instead of tun:
          v2raya --lite
        A forgotten password is reset with the service stopped:
          sudo v2raya --reset-password        (or v2raya --lite --reset-password)
      EOS
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [opt_bin/"v2raya"]
      require_root true
      keep_alive true
    end
end
