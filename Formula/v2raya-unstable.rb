class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230901.r1419.f21ce9e"
  
  $v2raya_version = "20230901.r1419.f21ce9e"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6044052512/v2raya_linux_x64_unstable-20230901.r1419.f21ce9e.zip"
  $sha_linux_x64 = "d8cb71f7763a16bb6d5649b4f32c0d91c0df0dd2bcfc44e48ce7e4f57f80b3bc"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6044052512/v2raya_darwin_x64_unstable-20230901.r1419.f21ce9e.zip"
  $sha_macos_x64 = "d78bed201ea8c37b4c8d959ca92458a014e5e2bf583270bde405eee10e2d7731"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6044052512/v2raya_darwin_arm64_unstable-20230901.r1419.f21ce9e.zip"
  $sha_macos_arm64 = "fc7531e7928757d2dfb40f8eeb04daf5e6b3ef593f95a1fe724270add5d75b57"

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
