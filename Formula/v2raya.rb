class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.1-3"
    
    $v2rayA_version = "2.0.1-3"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-3/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "A3CF5EC67836483CE49C927D1CF81C04A36F99DDCF4DA092AAC1FC3C62A8F59F"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-3/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "79EFD323D39955FB869DA2E931F4FDE8ADA53BCEB801C1B5E6BCE8AFC7E558B8"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-3/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "46EB0783B4D211B5684AC8DFAECF78D324F83A7E3F875A3EACFE13543DBE907E"

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
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray5", V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
