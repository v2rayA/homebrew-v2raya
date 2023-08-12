class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230812.r1361.8e21ef6"
  
  $v2raya_version = "20230812.r1361.8e21ef6"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5840913861/v2raya_linux_x64_unstable-20230812.r1361.8e21ef6.zip"
  $sha_linux_x64 = "11f702b968abd8afbfdeabdda5b13255df15fd5cc4e53f6cdcf5a854f0cbdec6"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5840913861/v2raya_darwin_x64_unstable-20230812.r1361.8e21ef6.zip"
  $sha_macos_x64 = "71c84b53a3ce4f913bc17a7d3c89cebfda486915073721e8270ed18387d7759b"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5840913861/v2raya_darwin_arm64_unstable-20230812.r1361.8e21ef6.zip"
  $sha_macos_arm64 = "7ba2d4aee1fcc59fe713b4e9a6b7c46780b0f275e0ee841468cb1362596a41a7"

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
