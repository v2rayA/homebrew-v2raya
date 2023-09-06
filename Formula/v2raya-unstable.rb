class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230906.r1435.709caf2"
  
  $v2raya_version = "20230906.r1435.709caf2"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6093946729/v2raya_linux_x64_unstable-20230906.r1435.709caf2.zip"
  $sha_linux_x64 = "7ce5657578e6bb87a6ca0e77df623c3e35e91a4bee130b203590bf83c41117b3"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6093946729/v2raya_darwin_x64_unstable-20230906.r1435.709caf2.zip"
  $sha_macos_x64 = "a247ecfd0f756cb28f2392badb1cf20e22e201af81228aa8e5f026ad5cf5843d"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6093946729/v2raya_darwin_arm64_unstable-20230906.r1435.709caf2.zip"
  $sha_macos_arm64 = "f90f0eca42034f7b96971151566013926c3300791667c49bac972e49ea8e3b29"

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
