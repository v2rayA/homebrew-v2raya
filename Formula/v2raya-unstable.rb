class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231019.r1441.b451eb4"
  
  $v2raya_version = "20231019.r1441.b451eb4"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6575488603/v2raya_linux_x64_unstable-20231019.r1441.b451eb4.zip"
  $sha_linux_x64 = "3e22acfd8a17c74fa3806fb11f69c3c887e5d152633950ce6056bc46dc25bbc3"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6575488603/v2raya_darwin_x64_unstable-20231019.r1441.b451eb4.zip"
  $sha_macos_x64 = "50f1334195b31abce7f89ad99a898aedbc9560d9fe5fd2586fd464ffd357162d"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6575488603/v2raya_darwin_arm64_unstable-20231019.r1441.b451eb4.zip"
  $sha_macos_arm64 = "de703e5b95063c642d4b706e732d97ab09bef9dc56d81dbdb174215793d9a424"

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
