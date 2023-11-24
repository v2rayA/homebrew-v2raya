class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231124.r1475.28c844f0"
  
  $v2raya_version = "20231124.r1475.28c844f0"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6976549926/v2raya_linux_x64_unstable-20231124.r1475.28c844f0.zip"
  $sha_linux_x64 = "7e3f7efcb8b792161f9882e307f4082726e2070086fbd7bf14d59a319931e769"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6976549926/v2raya_darwin_x64_unstable-20231124.r1475.28c844f0.zip"
  $sha_macos_x64 = "9c9d7dfaff5ccbdba002941d8ae160a0695ca243d3c0bfa7ecf69e1cd582d37d"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6976549926/v2raya_darwin_arm64_unstable-20231124.r1475.28c844f0.zip"
  $sha_macos_arm64 = "5d7d14e8117bd7725be365fa1c33c0a05e756e33e2f125116151fd4c138973e8"

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
