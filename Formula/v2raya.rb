class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "1.5.8.1-2"
 
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.8.1-2/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "8A4DC4D590DC28CF3A0B5F23C3C46DB908B7A22D244610752232D5FFF86042FE"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.8.1-2/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "72F500898C6D3924BA3E0B6B0AC912837668C94573FD364A7B8F4CA591534D25"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/1.5.8.1-2/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "2688BDCB029D247F8C0C05BE44ACDA306D29B7E15BD3C8DFF56808C7888D3D5E"
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
