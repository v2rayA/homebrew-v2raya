class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.5.7"
    
    $v2rayA_version = "2.2.5.7"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.7/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "ea1b65b190396123c17e6caa1c2cde83d8df6cfa319ba4be438f384ffbc2eace"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.7/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "037364a586318bf3b0cf237ad510ab52d577b4cdb3813ae7fa14e271f2abbdfe"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.7/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "bcc7848ddcd60c41bf81e433a52a999bfa5c6e5c178bc5a59f83b5ac86de005d"

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
