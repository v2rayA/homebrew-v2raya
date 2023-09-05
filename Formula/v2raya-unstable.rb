class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230905.r1430.c3ba6a8"
  
  $v2raya_version = "20230905.r1430.c3ba6a8"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6084325025/v2raya_linux_x64_unstable-20230905.r1430.c3ba6a8.zip"
  $sha_linux_x64 = "1122921644605d0e0c23338446f908ef518bbfbed2a542bca072ecf847d54fcf"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6084325025/v2raya_darwin_x64_unstable-20230905.r1430.c3ba6a8.zip"
  $sha_macos_x64 = "a04639ddef219865e8d070f6336d9ec8727766e8afe8f4a3aee23e908b4986ee"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6084325025/v2raya_darwin_arm64_unstable-20230905.r1430.c3ba6a8.zip"
  $sha_macos_arm64 = "abfe5818999cebe0b9e2bc128ccba8d060d136511af37fa9cc28ebaf211b7eff"

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
