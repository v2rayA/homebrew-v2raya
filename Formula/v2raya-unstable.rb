class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230814.r1379.54b783e"
  
  $v2raya_version = "20230814.r1379.54b783e"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5851920313/v2raya_linux_x64_unstable-20230814.r1379.54b783e.zip"
  $sha_linux_x64 = "bc4796c65cf9aeb9c2b69cc73a77c63514685918cc7b957101fb9f6aad2b14c3"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5851920313/v2raya_darwin_x64_unstable-20230814.r1379.54b783e.zip"
  $sha_macos_x64 = "b0b07ad252935815d5e8ab7f8c495c5ac391cf1a886b19282eb387a5f13886f0"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5851920313/v2raya_darwin_arm64_unstable-20230814.r1379.54b783e.zip"
  $sha_macos_arm64 = "897d2ed2753f3d5738596c4dfc82439fd1d69d96f33bd448d65cd68ac800a1f4"

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
