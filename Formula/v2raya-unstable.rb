class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230820.r1390.c47bf00"
  
  $v2raya_version = "20230820.r1390.c47bf00"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5914995735/v2raya_linux_x64_unstable-20230820.r1390.c47bf00.zip"
  $sha_linux_x64 = "1bfc1b97e6fc4e97a1d40066c8525ce2a4a7f0a540818249c9ae96ff3631acd4"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5914995735/v2raya_darwin_x64_unstable-20230820.r1390.c47bf00.zip"
  $sha_macos_x64 = "9658380ae621a6146de675b4c4bf2abe9aaddb0c5e9df3c3416cda78cb0a30f1"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5914995735/v2raya_darwin_arm64_unstable-20230820.r1390.c47bf00.zip"
  $sha_macos_arm64 = "26e98d9c13ec2e413745098686533dad7852a89e4b08a5ce61d68070c7efffb1"

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
