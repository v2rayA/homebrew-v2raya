class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230914.r1437.b848b56"
  
  $v2raya_version = "20230914.r1437.b848b56"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6184953564/v2raya_linux_x64_unstable-20230914.r1437.b848b56.zip"
  $sha_linux_x64 = "722972eb0cf408b3a6c8e05de1c84241bf68b0c5351a2c7204f81577deb7727f"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6184953564/v2raya_darwin_x64_unstable-20230914.r1437.b848b56.zip"
  $sha_macos_x64 = "77bc6c3664c9937fb60638b5fc93bd9faf446c957cc938e6c86fac8251442eeb"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6184953564/v2raya_darwin_arm64_unstable-20230914.r1437.b848b56.zip"
  $sha_macos_arm64 = "da3f51527c07c60c58c29d5446fe64f5febf5406308ab7e66fcab1e4b50fc725"

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
