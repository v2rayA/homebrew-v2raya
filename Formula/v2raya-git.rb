class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230204.d626ba"
 
    url "https://github.com/v2rayA/v2rayA/archive/d626ba112325c9830c3e8e90465286a4ea65bb9f.zip"
    sha256 "7D9EBD01E1FFF4CDD4FF609FFCB7F58BA9633916D97482CE73A558B7F09B1CA0"

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
