class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231125.r1479.c988e79b"
  
  $v2raya_version = "20231125.r1479.c988e79b"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6987292227/v2raya_linux_x64_unstable-20231125.r1479.c988e79b.zip"
  $sha_linux_x64 = "830fa835f84cab200565c21be3154e7487d340b182c0f45171bf36682d915880"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6987292227/v2raya_darwin_x64_unstable-20231125.r1479.c988e79b.zip"
  $sha_macos_x64 = "095822f7197647cef34cbdc5c12aefed93467158f5e1342b65eb93c63695b0ed"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6987292227/v2raya_darwin_arm64_unstable-20231125.r1479.c988e79b.zip"
  $sha_macos_arm64 = "8646c3ee39d15b94b53625cf2e99576a542aed1ec364a807f3f76606bf7fd919"

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
