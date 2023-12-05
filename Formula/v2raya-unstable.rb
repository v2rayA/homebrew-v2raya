class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231205.r1481.7eb931de"
  
  $v2raya_version = "20231205.r1481.7eb931de"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7101819328/v2raya_linux_x64_unstable-20231205.r1481.7eb931de.zip"
  $sha_linux_x64 = "04fba8250cc6e6d5231598bc02addfe9ffc1322ed389f53c0216a867dbf2e253"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7101819328/v2raya_darwin_x64_unstable-20231205.r1481.7eb931de.zip"
  $sha_macos_x64 = "22aa3b282b43df90722de991e84f372abadcf039a1e3c19859ee6a8ec09aefa1"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7101819328/v2raya_darwin_arm64_unstable-20231205.r1481.7eb931de.zip"
  $sha_macos_arm64 = "501ef27dffabf8f2c6d5c4eb02a4b9d9743624d2c50cf079d212873507922afd"

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
