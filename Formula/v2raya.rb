class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "1.5.7-13"
    ## Install v2rayA
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.7-13/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "D3428F866B33702E2BF5339757B9168BCCB7ACB13F1D08521F7080F152488D5B"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.7-13/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "A212BD13A92A2536A153F1D30A55497844FE9ED2E890FB921F811E99BC628BAC"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.7-13/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "CBA6579BDA84F81FAAA961E423F3265C90D71013DED017A2E98BFDF562517AB2"
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
