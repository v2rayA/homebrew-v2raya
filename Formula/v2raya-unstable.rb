class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231122.r1474.93bbed1a"
  
  $v2raya_version = "20231122.r1474.93bbed1a"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6956894609/v2raya_linux_x64_unstable-20231122.r1474.93bbed1a.zip"
  $sha_linux_x64 = "015e7938a6be497bff7281acf63d55ce94af8336856b79b7c11ac68237a87822"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6956894609/v2raya_darwin_x64_unstable-20231122.r1474.93bbed1a.zip"
  $sha_macos_x64 = "c49785756dd79ef87eac864e7fb361147c35bc9923713bbe3853aafe965cfe85"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6956894609/v2raya_darwin_arm64_unstable-20231122.r1474.93bbed1a.zip"
  $sha_macos_arm64 = "23001d73db3d5603d0bffe12842e71717f7060a806d073c5b96659af27289d9e"

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
