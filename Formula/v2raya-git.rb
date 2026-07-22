class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20260722.1edc9c8"
 
    url "https://github.com/v2rayA/v2rayA/archive/1edc9c868bccbdbcd2a17e9d886778c4d80576c6.zip"
    sha256 "0E26193F263EB043AC95D498FE390C191110D0A98F9811948BCC2E0C2C85AEC8"

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
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-git.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya-git", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya-git", "--lite", "--v2raya-core", bin/"v2raya_core-git"]
      keep_alive true
    end
end
