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
      # brew services runs this as root after `sudo brew services start`
      # and as the user otherwise; only root can have the tun transparent
      # proxy, so the user gets lite mode with the system proxy.
      (libexec/"v2raya-service").write <<~EOS
        #!/bin/sh
        if [ "$(id -u)" -eq 0 ]; then
          exec "#{opt_bin}/v2raya" "$@"
        fi
        exec "#{opt_bin}/v2raya" --lite "$@"
      EOS
      chmod 0755, libexec/"v2raya-service"
      rules_dat = Formula["v2ray-rules-dat"]
      mkdir_p share/"v2raya"
      File.symlink(rules_dat.opt_pkgshare/"geosite.dat", share/"v2raya"/"geosite.dat")
      File.symlink(rules_dat.opt_pkgshare/"geoip.dat", share/"v2raya"/"geoip.dat")
    end

    def caveats
      <<~EOS
        Started as root, the service has the tun transparent proxy:
          sudo brew services start v2raya
        Started as you, it runs in lite mode with the system proxy instead:
          brew services start v2raya
        A forgotten password is reset with the service stopped, with the same
        privileges the service had:
          sudo v2raya --reset-password    or    v2raya --lite --reset-password
      EOS
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [opt_libexec/"v2raya-service"]
      keep_alive true
    end
end
