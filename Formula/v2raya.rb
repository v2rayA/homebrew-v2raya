class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.4.5"
    
    $v2rayA_version = "2.2.4.5"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.5/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "73dbc607958f07f7948515a1674a923832676c546c6ea24455698062d2a9ebad"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.5/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "17f0e3abb7d7964171390f04f21d8cd485e9f077813cda8f986fa2ba66c571b4"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.4.5/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "d98eac52a1bc84cd2b593bf7b83ce6190bef0914102d1f2e18b4cad0d87ed128"

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
