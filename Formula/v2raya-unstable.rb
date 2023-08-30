class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230830.r1417.f515a9e"
  
  $v2raya_version = "20230830.r1417.f515a9e"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6024887884/v2raya_linux_x64_unstable-20230830.r1417.f515a9e.zip"
  $sha_linux_x64 = "1017483cc3597afeb179e6452cdf172a9c0fad68cf5b77469c5af2932528e4cb"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6024887884/v2raya_darwin_x64_unstable-20230830.r1417.f515a9e.zip"
  $sha_macos_x64 = "0aeb1502b14505e547b161636ab6ef542f7819c78acd569b9142d81d722f9da1"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6024887884/v2raya_darwin_arm64_unstable-20230830.r1417.f515a9e.zip"
  $sha_macos_arm64 = "e86734e6f2cc0daefc2274e479a8d9a441caba445a00d264cd4bf7d6488f1205"

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
