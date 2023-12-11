class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231211.r1486.b24e62fd"
  
  $v2raya_version = "20231211.r1486.b24e62fd"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7167752857/v2raya_linux_x64_unstable-20231211.r1486.b24e62fd.zip"
  $sha_linux_x64 = "98fe6a8317a90caa86f8a854e2dcfe81f43dcf7d80ea431223043062da7a1cef"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7167752857/v2raya_darwin_x64_unstable-20231211.r1486.b24e62fd.zip"
  $sha_macos_x64 = "85f5e385d72ecb1501d6d17e9840fc35952170186f8040526055a14748f9e49d"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/7167752857/v2raya_darwin_arm64_unstable-20231211.r1486.b24e62fd.zip"
  $sha_macos_arm64 = "098d67013387f23711ef670346d95eb4c1b72fe89bc6ee3c8725cdf802b4a16b"

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
