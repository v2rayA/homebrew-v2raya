class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.6.6"
    
    $v2rayA_version = "2.2.6.6"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.6/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "f2f91de0c219498b907bcfc135dd4aabc05592df5591ffb2b7c3e968549a55f3"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.6/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "271b740e06060be80df6c0cf3ee4e7c9a350495502021b7d0480649e3118428e"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.6.6/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "ebb0b0806d330308e1f32c048c2237fe9e793d7d3bafd0fb52bab7f41eb9cd1d"

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
