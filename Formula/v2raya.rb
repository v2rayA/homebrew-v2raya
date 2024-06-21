class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.5.6"
    
    $v2rayA_version = "2.2.5.6"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.6/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "ab201e90c54f98e14c2038fbe2b0be2f81f3e3f36e8d5e4f1ae63a0fbd1cd7a2"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.6/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "1b19f4d3c8a0c77a822ae006833a8efa06a140e7b672348e1bf6e9e33136baa9"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.6/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "24c54fbe7f3ebf7192d3f53aa29e05cff8074f0fb5e6d6dfe50737e315bc9ff9"

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
