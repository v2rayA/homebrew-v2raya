class V2raya < Formula
    desc "Web client for its own Xray-based core, with transparent proxy"
    homepage "https://github.com/v2rayA/v2rayA"
    license "AGPL-3.0-only"
    version "2.5.10"

    $v2rayA_version = "2.5.10"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.5.10/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "d5aecdf958451209f96dd97fe5c19bc10926246509a2bbcd31183781c2e8abff"
    $url_linux_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.5.10/v2raya-arm64-linux.zip"
    $sha_linux_arm64 = "f8930799e69410f0e03e54615b6921883d2b7ff257b6315936b1e4129aff019f"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.5.10/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "838addea7875b2154f923069be3a23038f4c3e6d012412ebfe6c139706a99536"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.5.10/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "4dfb0094219f13ecc12762d35073ef6d35c3e07a9c855713dea7e50edc49ac4e"

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
