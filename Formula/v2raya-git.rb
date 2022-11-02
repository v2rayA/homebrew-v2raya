class V2rayaGit < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20221004.r1225.11aa2b0"
 
    url "https://github.com/v2rayA/v2rayA/archive/11aa2b0a982989983fd086510f8fea864ed92deb.zip"
    sha256 "ac4384f7e12408f6734b38069fef6aa0e124c2050660e1570a08715e3b1b7a86"

    depends_on "v2ray5"
    depends_on "go" => :build
    depends_on "node" => :build
    depends_on "yarn" => :build

    def install
      system "/bin/bash", "-c", "./build.sh"
      bin.install "v2raya" => "v2raya-git"
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray5", V2RAYA_LOG_FILE: "/tmp/v2raya_feat_v5.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2ray5"
      run [bin/"v2raya-git", "--lite"]
      keep_alive true
    end
end
