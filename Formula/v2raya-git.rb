class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230213.58a6cf"
 
    url "https://github.com/v2rayA/v2rayA/archive/58a6cf270e43ec3eaeef7d1c65de76278dd6d349.zip"
    sha256 "01DFA58CF083B93A3BC707DD8029ACC8E48DD566C19904E219F5F6C7DEC8986D"

    depends_on "v2ray5"
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
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray", V2RAYA_LOG_FILE: "/tmp/v2raya_feat_v5.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:"
      run [bin/"v2raya-git", "--lite"]
      keep_alive true
    end
end
