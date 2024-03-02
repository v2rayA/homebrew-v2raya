class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20240302.r1515.d8c97984"
  
  $v2raya_version = "20240302.r1515.d8c97984"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8123556414/v2raya_linux_x64_unstable-20240302.r1515.d8c97984.zip"
  $sha_linux_x64 = "4f9537223bcdea51ce3a5fb5bea5b957982869136ea6f6240d6a2cd83ee732d2"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8123556414/v2raya_darwin_x64_unstable-20240302.r1515.d8c97984.zip"
  $sha_macos_x64 = "9487066c5df26002f80b8d3f8c0a9f84c1c16d6d57d8a4872069cb983222d16a"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8123556414/v2raya_darwin_arm64_unstable-20240302.r1515.d8c97984.zip"
  $sha_macos_arm64 = "93ec0924e6c8c9c5638d89323e90b81a903298b616f428697a811f9269665366"

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
