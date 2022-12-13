class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.0"
 
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.0/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "51BB63DD931852784566347EEB556E216325FEEA22987F0E1B93C32666DD229A"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.0/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "CF6375DC97608E617769FA24CB4112E93FDE768A40B39367915F04BAA4412B04"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.0/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "B250B6A2BAC53E2F0AED3C7F356BF2E4A30F6E660CDAE521F3AA8FDFC9300D88"
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
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray5", V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2ray5"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
