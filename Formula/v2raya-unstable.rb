class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230406.r1331.36d4ad9"
    
    $v2raya_version = "20230406.r1331.36d4ad9"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4629842277/v2raya_linux_x64_unstable-20230406.r1331.36d4ad9.zip"
    $sha_linux_x64 = "08802454e7830550ea3dc4235541adad2051c03a9ded0bf33c2578e4e2b230b9"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4629842277/v2raya_darwin_x64_unstable-20230406.r1331.36d4ad9.zip"
    $sha_macos_x64 = "f51c5d5813f88a3e26e94992d7e2abc08a8ca919f0b4ba396279558b5cc6ef91"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4629842277/v2raya_darwin_arm64_unstable-20230406.r1331.36d4ad9.zip"
    $sha_macos_arm64 = "a422d1d61f33e3e05f6686b05f2e8073e33066296cb0e733d9404cf2de5254d4"

    if OS.linux?
      url $url_linux_x64
      sha256 $sha_linux_x64
      $os_type = "linux_x64"
    elsif Hardware::CPU.intel?
      url $url_macos_x64
      sha256 $sha_macos_x64
      $os_type = "darwin_x64"
      else
      url $url_macos_arm64
      sha256 $sha_macos_arm64
      $os_type = "darwin_arm64"
    end

    depends_on "v2ray"

    def install
      bin.install "v2raya_#{$os_type}_unstable-#{version}" => "v2raya-unstable"
      puts "v2raya-unstable installed, don't run both v2raya and v2raya-unstable service at the same time, or write launchd's plist file yourself to specify ports used by v2raya-unstable."
      puts "If you forget your password, stop running v2raya-unstable, then run `v2raya-unstable --lite --reset-password` to reset password."
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-unstable.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya-unstable", "--lite"]
      keep_alive true
    end
end
