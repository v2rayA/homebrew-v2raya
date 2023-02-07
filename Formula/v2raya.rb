class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.1-2"
 
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-2/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "9476A08FD381EDDCD5652AC8473343FFF71B4AF63D86AB562D3B4DB76A54412B"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-2/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "FDADB32BFE014482C3C2BD3BCBB625FB54C72B4EF8348927CD35A29AF48673E4"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-2/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "8B9CA935AFAE8CFE93B1C9A8F5427C51E6A3A08DDDF14A969826E88E9CAD29C6"
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

    depends_on "v2ray5"

    def install
      bin.install "v2raya"
      # pkgshare.install "geoip.dat"
      # pkgshare.install "geosite.dat"
      # pkgshare.install "geoip-only-cn-private.dat"
      # pkgshare.install "LoyalsoldierSite.dat"
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray5", V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
