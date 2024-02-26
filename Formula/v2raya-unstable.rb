class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20240226.r1505.d4dd7ff9"
  
  $v2raya_version = "20240226.r1505.d4dd7ff9"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8044921892/v2raya_linux_x64_unstable-20240226.r1505.d4dd7ff9.zip"
  $sha_linux_x64 = "a3d3118f72fdb0d26291487936aede7110d3f82da947f4c1b1a554e6fa76c797"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8044921892/v2raya_darwin_x64_unstable-20240226.r1505.d4dd7ff9.zip"
  $sha_macos_x64 = "ff4e23f42c7495eb5c465f3b05424b343b79cb5dc5cdedc6fbb396693b1518cf"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8044921892/v2raya_darwin_arm64_unstable-20240226.r1505.d4dd7ff9.zip"
  $sha_macos_arm64 = "33854bddfa88c480ecc06116ef8374d03bc52efb48046da2541391075efd4777"

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
