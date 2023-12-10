class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231210.r1483.7721c96d"
  
  $v2raya_version = "20231210.r1483.7721c96d"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7158426045/v2raya_linux_x64_unstable-20231210.r1483.7721c96d.zip"
  $sha_linux_x64 = "21359a44bfbef29605b2d9dee8c6efdf4b374b0b5aeaa0b5b0cf18b82877ca86"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7158426045/v2raya_darwin_x64_unstable-20231210.r1483.7721c96d.zip"
  $sha_macos_x64 = "43bbe7596cb879c9d5bc20447485ce18e3f4c06c0c71f96ba76f35f4dee2ee22"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7158426045/v2raya_darwin_arm64_unstable-20231210.r1483.7721c96d.zip"
  $sha_macos_arm64 = "6cf29b645022638ab2625f1cf3695cb109aed0fba9602de8269908145f7be7c1"

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
