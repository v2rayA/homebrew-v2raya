class V2rayaGit < Formula
    desc "Web client for its own Xray-based core, with transparent proxy"
    homepage "https://github.com/v2rayA/v2rayA"
    license "AGPL-3.0-only"
    version "20260924.bdbc305"
 
    url "https://github.com/v2rayA/v2rayA/archive/bdbc305e97dd780478d93c4ed5ced8a4e3c898a8.zip"
    sha256 "759C4F3A57041A5F10975D999AAAA0345EFA706228C4CACD66AD3C0582888B4E"

    depends_on "go" => :build
    depends_on "node" => :build
    depends_on "yarn" => :build
    depends_on "v2ray-rules-dat"

    def install
        ENV.deparallelize
        # ENV['PATH'] = "#{HOMEBREW_PREFIX}/opt/node@20/bin:#{ENV['PATH']}"
        chdir "gui" do
          system "yarn"
          system "yarn", "build"
        end
        cp_r "web", "service/server/router/"
        chdir "service" do
          system "go build -o \"v2raya\" -ldflags \"-X github.com/v2rayA/v2rayA/conf.Version=unstable-#{version} -s -w\""
        end
        chdir "core" do
          system "go build -o \"v2raya_core\" -ldflags \"-X main.Version=unstable-#{version} -s -w\" ./main"
        end
      rules_dat = Formula["v2ray-rules-dat"]
      mkdir_p share/"v2raya-git"
      File.symlink(rules_dat.opt_pkgshare/"geosite.dat", share/"v2raya-git"/"geosite.dat")
      File.symlink(rules_dat.opt_pkgshare/"geoip.dat", share/"v2raya-git"/"geoip.dat")
      cp_r "service/v2raya", "v2raya-git"
      cp_r "core/v2raya_core", "v2raya_core-git"
      bin.install "v2raya-git"
      bin.install "v2raya_core-git"
      # brew services runs this as root after `sudo brew services start`
      # and as the user otherwise. Only root can have the tun transparent
      # proxy, so the user gets lite mode with the system proxy; each keeps
      # a log it can write.
      (libexec/"v2raya-git-service").write <<~EOS
        #!/bin/sh
        if [ "$(id -u)" -eq 0 ]; then
          export V2RAYA_LOG_FILE="${V2RAYA_LOG_FILE:-#{var}/log/v2raya-git.log}"
          exec "#{opt_bin}/v2raya-git" "--v2ray-bin" "#{opt_bin}/v2raya_core-git" "$@"
        fi
        case "$(uname)" in
          Darwin) log="$HOME/Library/Logs/v2raya-git/v2raya-git.log" ;;
          *) log="${XDG_STATE_HOME:-$HOME/.local/state}/v2raya-git/v2raya-git.log" ;;
        esac
        export V2RAYA_LOG_FILE="${V2RAYA_LOG_FILE:-$log}"
        exec "#{opt_bin}/v2raya-git" --lite "--v2ray-bin" "#{opt_bin}/v2raya_core-git" "$@"
      EOS
      chmod 0755, libexec/"v2raya-git-service"
    end

    service do
      environment_variables V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya-git", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [opt_libexec/"v2raya-git-service"]
      keep_alive true
    end
end
