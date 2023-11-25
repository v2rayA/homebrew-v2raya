class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231125.r1476.452f1ff6"
  
  $v2raya_version = "20231125.r1476.452f1ff6"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6986124573/v2raya_linux_x64_unstable-20231125.r1476.452f1ff6.zip"
  $sha_linux_x64 = "d682ff42b2a49f389992f813f1f0ba82df20c31f3f1bcaa965864a2e58458a22"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6986124573/v2raya_darwin_x64_unstable-20231125.r1476.452f1ff6.zip"
  $sha_macos_x64 = "3eddd67a2e3324ddad13066fd0fa9ec87b2ad2efba2326bd030d50bf26af22bf"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6986124573/v2raya_darwin_arm64_unstable-20231125.r1476.452f1ff6.zip"
  $sha_macos_arm64 = "876a55e54933e40608652eea27ea3e10eae2237da90f97da85b383b38ea638fc"

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
