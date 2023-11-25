class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20231125.452f1ff"
 
    url "https://github.com/v2rayA/v2rayA/archive/452f1ff62868cbd5e36a243dbc439b154887dc37.zip"
    sha256 "F3B25E7318BBE86666C2CE58F9A31F8F80C18236C589A0F716F9B81CB80E40D0"

    depends_on "v2ray"
    depends_on "go" => :build
    depends_on "node" => :build
    depends_on "yarn" => :build

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
      cp_r "service/v2raya", "v2raya-git"
      bin.install "v2raya-git"
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-git.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya-git", "--lite"]
      keep_alive true
    end
end
