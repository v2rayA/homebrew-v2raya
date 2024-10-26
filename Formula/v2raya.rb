class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.6.2"
    
    $v2rayA_version = "2.2.6.2"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.2/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "c6a96c598e54fcbee6a12b342b425e2f0f2d33460fd34ebe1cf7f9094880b030"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.2/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "4d1ca1b75676efab6826b3a9364ee4dcc2141ca787dcfa366b06c960ae017790"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.2/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "d464e7a6443101133b8d202630a743d549d242531e877fb38148914ec303a035"

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
      puts "If you forget your password, stop running v2raya, then run `v2raya --lite --reset-password` to reset password."
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
