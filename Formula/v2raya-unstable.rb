class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230808.r1356.a670323"
  
  $v2raya_version = "20230808.r1356.a670323"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5791674195/v2raya_linux_x64_unstable-20230808.r1356.a670323.zip"
  $sha_linux_x64 = "4c470c3a53fa48844e4d5b00cbc2892aebf8cf2c67fa1aa3cf2760ee4f362021"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5791674195/v2raya_darwin_x64_unstable-20230808.r1356.a670323.zip"
  $sha_macos_x64 = "ca53305237587c2719ad8905dd7132d86afa0e53080589ec8ae4555117335a18"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5791674195/v2raya_darwin_arm64_unstable-20230808.r1356.a670323.zip"
  $sha_macos_arm64 = "d87f74d69b19ae6974ba68a25f5aa448195497d1886fc79f4d0e1a9037c14ecc"

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
