class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.1-3"
    
    $v2rayA_version = "2.0.1-3"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-3/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "fd2ba0f771ab32449dcf8e8575f49af891ee869b854420a7c393f89f807a0bc5"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-3/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "c75825a06e1d836f4ff31cf45b83aee2c2bfdc982d78a6ca10cde279a04ce885"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-3/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "c8ae152bfc987367ed54abd3426c5402e60cdb61669d659178cf12fc60f7c206"

    if OS.linux?
      url $url_linux_x64
      sha256 $sha_linux_x64
    elsif Hardware::CPU.intel?
      url $url_macos_x64
      sha256 $sha_macos_x64
      else
      url $url_macos_arm64
      sha256 $sha_macos_arm64
    end

    depends_on "v2ray"

    def install
      bin.install "v2raya"
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray", V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
