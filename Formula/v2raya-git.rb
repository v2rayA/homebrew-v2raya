class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230511.6969922"
 
    url "https://github.com/v2rayA/v2rayA/archive/696992270743b7ad395fc63879bd4a32f10301a3.zip"
    sha256 "5DDA28F125BC201C2A5A70F472C96D0E310208A287F15E071D448C9723460137"

    depends_on "v2ray"
    depends_on "go" => :build
    depends_on "node" => :build
    depends_on "yarn" => :build

    def install
        ENV.deparallelize
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
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-git.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya-git", "--lite"]
      keep_alive true
    end
end
