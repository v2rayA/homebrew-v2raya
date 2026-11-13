class V2raya < Formula
    desc "Web client for its own Xray-based core, with transparent proxy"
    homepage "https://github.com/v2rayA/v2rayA"
    license "AGPL-3.0-only"
    version "2.5.15"

    $v2rayA_version = "2.5.15"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.5.15/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "515a12c4ffe540304d0ed19c358b5e3534dea94fbadc13f583b71ed62159cf2e"
    $url_linux_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.5.15/v2raya-arm64-linux.zip"
    $sha_linux_arm64 = "e9eb65f44f75c05cf815660fb9b8b6b1c3a3abf5f49c368253ba91fa9b23ae14"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.5.15/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "c6da567d0c8ee564f9ffa43934c4383d6c877e19986567b7e03d807bc5a927c3"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.5.15/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "9b1dfadb8cd9f7d50b1b38ff42a233c13c85d3ec8d3fd11cb1db31652c85fd30"

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
      # and as the user otherwise. Only root can have the tun transparent
      # proxy, so the user gets lite mode with the system proxy; each keeps
      # a log it can write.
      (libexec/"v2raya-service").write <<~EOS
        #!/bin/sh
        if [ "$(id -u)" -eq 0 ]; then
          export V2RAYA_LOG_FILE="${V2RAYA_LOG_FILE:-#{var}/log/v2raya.log}"
          exec "#{opt_bin}/v2raya" "$@"
        fi
        case "$(uname)" in
          Darwin) log="$HOME/Library/Logs/v2raya/v2raya.log" ;;
          *) log="${XDG_STATE_HOME:-$HOME/.local/state}/v2raya/v2raya.log" ;;
        esac
        export V2RAYA_LOG_FILE="${V2RAYA_LOG_FILE:-$log}"
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
        Logs: #{var}/log/v2raya.log as root, ~/Library/Logs/v2raya/ as you.
        A forgotten password is reset with the service stopped, with the same
        privileges the service had:
          sudo v2raya --reset-password    or    v2raya --lite --reset-password
      EOS
    end

    service do
      environment_variables V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [opt_libexec/"v2raya-service"]
      keep_alive true
    end
end
