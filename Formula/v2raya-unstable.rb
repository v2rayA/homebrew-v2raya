class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230803.r1353.50ae041"
    
    $v2raya_version = "20230803.r1353.50ae041"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5741263785/v2raya_linux_x64_unstable-20230803.r1353.50ae041.zip"
    $sha_linux_x64 = "97b04ca2727342eaa4d1e7b87b8112f7894d50b851bc3819cd92b8d5442974ff"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5741263785/v2raya_darwin_x64_unstable-20230803.r1353.50ae041.zip"
    $sha_macos_x64 = "8b4b180e2e86aec6e983f6c0b65d9845c2ea1368496884fba075850e37ebfb8e"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5741263785/v2raya_darwin_arm64_unstable-20230803.r1353.50ae041.zip"
    $sha_macos_arm64 = "9d442141c84ec9e1c5b43374bf6cef1cdf0f8233faa8b8910d69f5b7cc35eedd"

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
