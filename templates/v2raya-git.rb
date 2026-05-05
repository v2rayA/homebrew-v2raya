class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "Current_Version"
 
    url "Current_Source_Url"
    sha256 "Current_File_Hash"

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
        chdir "core" do
          system "go build -o \"v2raya_core\" -ldflags \"-X main.Version=unstable-#{version} -s -w\" ./main"
        end
      cp_r "service/v2raya", "v2raya-git"
      cp_r "core/v2raya_core", "v2raya_core-git"
      bin.install "v2raya-git"
      bin.install "v2raya_core-git"
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-git.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya-git", "--lite", "--v2raya-core", bin/"v2raya_core-git"]
      keep_alive true
    end
end
