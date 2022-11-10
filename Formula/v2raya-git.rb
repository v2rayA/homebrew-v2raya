class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20221110.6b70de"
 
    url "https://github.com/v2rayA/v2rayA/archive/6b70de7895a214239ced939750daf019a259b9f8.zip"
    sha256 "0548247663F58B3AA1CBB1CD3248D28F3323A942EECE3AC11367C67C1ECFEB79"

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
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray5", V2RAYA_LOG_FILE: "/tmp/v2raya_feat_v5.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2ray5"
      run [bin/"v2raya-git", "--lite"]
      keep_alive true
    end
end
