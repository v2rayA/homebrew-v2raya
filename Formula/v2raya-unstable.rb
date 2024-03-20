class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20240320.r1517.8b864a22"
  
  $v2raya_version = "20240320.r1517.8b864a22"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8358395105/v2raya_linux_x64_unstable-20240320.r1517.8b864a22.zip"
  $sha_linux_x64 = "03d50422e631647b41b262835b27f469e32d2bce90bc001e71fa5c607cec2d62"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8358395105/v2raya_darwin_x64_unstable-20240320.r1517.8b864a22.zip"
  $sha_macos_x64 = "13ce920d2b507a332f6104aac557cb95d11a881070327620363d4b6551b5ba66"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/8358395105/v2raya_darwin_arm64_unstable-20240320.r1517.8b864a22.zip"
  $sha_macos_arm64 = "e802e538b30b765573d4633cb6cb0bb3a49d746edded83c1f6846edb162de60b"

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
