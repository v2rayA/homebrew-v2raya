class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20240619.r1542.62c14cc9"
  
  $v2raya_version = "20240619.r1542.62c14cc9"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/9583726828/v2raya_linux_x64_unstable-20240619.r1542.62c14cc9.zip"
  $sha_linux_x64 = "0053c4c86abc9b155b4e30ba825e1d0186407ded9f6b4cbab0d4c47499f71203"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/9583726828/v2raya_darwin_x64_unstable-20240619.r1542.62c14cc9.zip"
  $sha_macos_x64 = "50cc482d1eba12baeacb7cc3770791feb043de1fd167ae33338a8b787c9f23ea"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/9583726828/v2raya_darwin_arm64_unstable-20240619.r1542.62c14cc9.zip"
  $sha_macos_arm64 = "2bdd8678ff00ecc5bb2fe52e559df6411200c2c4681eadbc08a16c76cf7f0fc1"

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
