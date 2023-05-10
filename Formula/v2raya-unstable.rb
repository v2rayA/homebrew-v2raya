class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230510.r1340.25975fb"
    
    $v2raya_version = "20230510.r1340.25975fb"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4937998344/v2raya_linux_x64_unstable-20230510.r1340.25975fb.zip"
    $sha_linux_x64 = "ad2e5f367d2b23edf70d41e5ddf49999634cece75026fc8c02a579e5366138a2"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4937998344/v2raya_darwin_x64_unstable-20230510.r1340.25975fb.zip"
    $sha_macos_x64 = "65cb2cc1b56c96e8f4eca067bf3a672bf547b3cf8e74fee7efebd2a3dd31d4eb"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4937998344/v2raya_darwin_arm64_unstable-20230510.r1340.25975fb.zip"
    $sha_macos_arm64 = "161bc72522234ac938e882178de8813826fb7c47605368987eaed8f517ef1221"

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
