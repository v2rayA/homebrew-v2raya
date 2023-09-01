class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230831.r1411.7d3dfd1"
  
  $v2raya_version = "20230831.r1418.7d3dfd1"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6039455126/v2raya_linux_x64_unstable-20230831.r1418.7d3dfd1.zip"
  $sha_linux_x64 = "bfd1a0f53771bf4de4e2ec7a0d526435332510904b930bbef967181ccaa16816"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6039455126/v2raya_darwin_x64_unstable-20230831.r1418.7d3dfd1.zip"
  $sha_macos_x64 = "bd4937cb4f11ff0467789014bb5083d53b7e096c3f26556a7166de05384dead6"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6039455126/v2raya_darwin_arm64_unstable-20230831.r1418.7d3dfd1.zip"
  $sha_macos_arm64 = "be01374bcf592aa49c3a669eb27fcd06e90af272df81da81a6dd334c6157d51f"

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
