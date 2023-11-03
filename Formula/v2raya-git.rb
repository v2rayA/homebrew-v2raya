class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20231101.d1f9b4e"
 
    url "https://github.com/v2rayA/v2rayA/archive/d1f9b4eb8d1ba11cb0fc1f9febc81605acd92aea.zip"
    sha256 "DC3477251E12694E9E95111189C3A9B2385F498AA7C35F824D34289A77266B01"

    depends_on "v2ray"
    depends_on "go" => :build
    depends_on "node@20" => :build
    depends_on "yarn" => :build

    def install
        ENV.deparallelize
        ENV['PATH'] = "#{HOMEBREW_PREFIX}/opt/node@20/bin:#{ENV['PATH']}"
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
