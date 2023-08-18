class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230815.r1386.1ae8d3d"
  
  $v2raya_version = "20230815.r1386.1ae8d3d"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5866281518/v2raya_linux_x64_unstable-20230815.r1386.1ae8d3d.zip"
  $sha_linux_x64 = "83b8ed9d8b360feeabadc66e50e5f4733a3e90607a7a3ee7a4d4d002630cc9a7"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5866281518/v2raya_darwin_x64_unstable-20230815.r1386.1ae8d3d.zip"
  $sha_macos_x64 = "df43b4852e8c8da46432fae85ca05d20cc4434df9244c86b234a425a89b52966"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5866281518/v2raya_darwin_arm64_unstable-20230815.r1386.1ae8d3d.zip"
  $sha_macos_arm64 = "9a6c51cb057fa5e4a3b29ccf060beeb905921480efa5d3c9258618119cb666d2"

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
