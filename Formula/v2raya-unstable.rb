class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230417.r1335.14cad75"
    
    $v2raya_version = "20230417.r1335.14cad75"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4719138604/v2raya_linux_x64_unstable-20230417.r1335.14cad75.zip"
    $sha_linux_x64 = "4c4a0b599d0b7568e8b601e1d9d1c843c335510626edb2d2494324bd04fed1fc"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4719138604/v2raya_darwin_x64_unstable-20230417.r1335.14cad75.zip"
    $sha_macos_x64 = "277b3577d3aad54a9382b00d946ea8e39bd02567f85d086aec6dc6e07f40580d"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4719138604/v2raya_darwin_arm64_unstable-20230417.r1335.14cad75.zip"
    $sha_macos_arm64 = "427a05a6b402f4f1b63e3451d81061daec1c2ea0754b48dd5aa30606471963ee"

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
