class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231118.r1470.3c2873dc"
  
  $v2raya_version = "20231118.r1470.3c2873dc"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6915081016/v2raya_linux_x64_unstable-20231118.r1470.3c2873dc.zip"
  $sha_linux_x64 = "99e655a6f33a3d8ecd72b99a7da92d1df110278be33c13245eac76c78d9ffa0c"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6915081016/v2raya_darwin_x64_unstable-20231118.r1470.3c2873dc.zip"
  $sha_macos_x64 = "3fa7f23f66e56c023698b63e15d89e0919c6a8a5993998e84a598a97182e81c1"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6915081016/v2raya_darwin_arm64_unstable-20231118.r1470.3c2873dc.zip"
  $sha_macos_arm64 = "215c6acb561046f3c2788b752f22d5b6a4d1fee530deb3daaf102f29c7fd527a"

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
