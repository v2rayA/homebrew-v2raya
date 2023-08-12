class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20230812.r1357.0e4803c"
  
  $v2raya_version = "20230812.r1357.0e4803c"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5839646570/v2raya_linux_x64_unstable-20230812.r1357.0e4803c.zip"
  $sha_linux_x64 = "0f01ea98b5412d1959d04922e6a99d96a0770e621ac2ef9a9315ab559d6786d6"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5839646570/v2raya_darwin_x64_unstable-20230812.r1357.0e4803c.zip"
  $sha_macos_x64 = "590bfbc581173e4e9c082b24ce4f2567a63d5a4fa6152f7e0eef99d950e65a1d"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5839646570/v2raya_darwin_arm64_unstable-20230812.r1357.0e4803c.zip"
  $sha_macos_arm64 = "11c680e5a5aeded5707f6ccb6e233340525f8330e40149cad296e5e806d2e581"

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
    environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-unstable.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
    run [bin/"v2raya-unstable", "--lite"]
    keep_alive true
  end
end
