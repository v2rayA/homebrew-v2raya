class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.5.2"
    
    $v2rayA_version = "2.2.5.2"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.2/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "7548e86cadc8429142f4ade6f8174230ec2df43310192add166cd5969f2f10f9"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.2/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "e72d3678e02b4a85dba3c9d7de11cbb92f65c9c5eeaf195ff4334c10e8a03bbd"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.2.5.2/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "a0d4cdb8f3af54360c84c7bb3ae45d74847b4b8081c852517298b82fc8dae3eb"

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
