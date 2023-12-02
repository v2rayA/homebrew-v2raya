class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231202.r1480.0459bad0"
  
  $v2raya_version = "20231202.r1480.0459bad0"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7068817449/v2raya_linux_x64_unstable-20231202.r1480.0459bad0.zip"
  $sha_linux_x64 = "26c46aba0d98db10c814e8a49c36d1186f60424ee5cbe00712db015d52c60392"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7068817449/v2raya_darwin_x64_unstable-20231202.r1480.0459bad0.zip"
  $sha_macos_x64 = "e002b7ebabefc8089cf1d97392d2a1cd1e0c9433ef9c49b5ec8834484641ed98"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7068817449/v2raya_darwin_arm64_unstable-20231202.r1480.0459bad0.zip"
  $sha_macos_arm64 = "c834f1c555320113dfc004569522e9b1bc9f877b0d37977c3f98d68bcaac2d6d"

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
