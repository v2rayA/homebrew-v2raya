class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230617.r1344.6f0f210"
    
    $v2raya_version = "20230617.r1344.6f0f210"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5292007149/v2raya_linux_x64_unstable-20230617.r1344.6f0f210.zip"
    $sha_linux_x64 = "c2c75d93add9b8a35b8f8af7c18bfc7cb6a3658f81fa5917f9adb7ed1829057f"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5292007149/v2raya_darwin_x64_unstable-20230617.r1344.6f0f210.zip"
    $sha_macos_x64 = "b4b129d2def349da6573ac9aad2bcaf75fb6c67bcfb280c3fded74873dc59ea1"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5292007149/v2raya_darwin_arm64_unstable-20230617.r1344.6f0f210.zip"
    $sha_macos_arm64 = "d655cd5cbec03d94f44259a55123bb7b51cc795b939872eee32fad7a96515c4a"

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
