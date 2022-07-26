class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "1.5.8.1-4"
 
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.8.1-4/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "48129DA6CE876DE25E3496625C8895FBED9E61355EB9BEE2A240897374C3E5C2"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.8.1-4/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "C3E62FAE4859D26DA7A7DBC74C1C41C064008C4822E6C32A1F09E6ACF1BC85A2"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.8.1-4/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "9E1FDB3BBB8FB3AB7C3B3B240C69B4A6EFB01FD9033B4F73623FDD93BDA7D802"
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
