class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20231105.dfe0078"
 
    url "https://github.com/v2rayA/v2rayA/archive/dfe0078ee0d339a181ba91642ea0120148c17a48.zip"
    sha256 "A0EF57149478AB8509B74B7818C58774C37B9C641AE12C02A273E74D59B4CFDB"

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
