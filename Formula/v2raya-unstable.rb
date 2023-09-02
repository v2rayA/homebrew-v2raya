class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230902.r1421.f73fd7c"
  
  $v2raya_version = "20230902.r1421.f73fd7c"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6058087107/v2raya_linux_x64_unstable-20230902.r1421.f73fd7c.zip"
  $sha_linux_x64 = "9e240a5a12c2f8b19240c2539b45c25ccdf4ff2171f5e402d4066cccb1cac0d6"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6058087107/v2raya_darwin_x64_unstable-20230902.r1421.f73fd7c.zip"
  $sha_macos_x64 = "c86a380430ec3067f675ae548da73cb7366aca3053e604b3ec371781b768f7af"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6058087107/v2raya_darwin_arm64_unstable-20230902.r1421.f73fd7c.zip"
  $sha_macos_arm64 = "f08e62dd8a3547c35d238f75ae25c5672d9b678b7f0f751a24ad3ec48dd1db8d"

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
