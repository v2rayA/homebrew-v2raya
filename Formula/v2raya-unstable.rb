class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231120.r1472.b664fba9"
  
  $v2raya_version = "20231120.r1472.b664fba9"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6924457307/v2raya_linux_x64_unstable-20231120.r1472.b664fba9.zip"
  $sha_linux_x64 = "ebe8b584eb3f032104830c6c6d737d716e9ecf791d2820374e2ababea8e02984"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6924457307/v2raya_darwin_x64_unstable-20231120.r1472.b664fba9.zip"
  $sha_macos_x64 = "92993949081b4018f9bf38c056f4389892d7dcd10647480021946827ac764ca4"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6924457307/v2raya_darwin_arm64_unstable-20231120.r1472.b664fba9.zip"
  $sha_macos_arm64 = "7f7ab6afa51a89ff2e5faea436397b1af08267fbfd73fc933a1d3dd278b4abde"

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
