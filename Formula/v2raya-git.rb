class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230319.2a78a0"
 
    url "https://github.com/v2rayA/v2rayA/archive/2a78a0a6c7db06601658639882b733f92ecddc4b.zip"
    sha256 "81FCE7F3AF8A9E94DDF8A6A6A6B8AB6982AF452AD78B5880658CD97A923DD980"

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
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya_feat_v5.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:"
      run [bin/"v2raya-git", "--lite"]
      keep_alive true
    end
end
