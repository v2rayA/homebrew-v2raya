class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20240301.r1512.81ee7cb6"
  
  $v2raya_version = "20240301.r1512.81ee7cb6"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8110568895/v2raya_linux_x64_unstable-20240301.r1512.81ee7cb6.zip"
  $sha_linux_x64 = "f3dc49c8cceb6f7c42075ec915c5ba5720c047ce77d6c3dcbe1f5b6bf8b39b41"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8110568895/v2raya_darwin_x64_unstable-20240301.r1512.81ee7cb6.zip"
  $sha_macos_x64 = "cbd80875e7e58f6013925e6fc018832b6e831d8a5deb266ebd5ceb065fbec26b"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8110568895/v2raya_darwin_arm64_unstable-20240301.r1512.81ee7cb6.zip"
  $sha_macos_arm64 = "5fd7b84f0b82912a0f0eba74ba58ec36982671e809a8be33151689e7aea16d47"

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
    environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-unstable.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
    run [bin/"v2raya-unstable", "--lite"]
    keep_alive true
  end
end
