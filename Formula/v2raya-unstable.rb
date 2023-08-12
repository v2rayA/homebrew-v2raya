class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version ""
    
    $v2raya_version = ""
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5839660426/v2raya_linux_x64_unstable-.zip"
    $sha_linux_x64 = "1abe48fa2093c43daf177f7db213e1d07d71b90104e43fdf0b375c29d2ffd052"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5839660426/v2raya_darwin_x64_unstable-.zip"
    $sha_macos_x64 = "d096d51fc1e696cfff3b17520373a3c179da496368119df3f0768300844e4d88"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5839660426/v2raya_darwin_arm64_unstable-.zip"
    $sha_macos_arm64 = "936dfbde9d1c4c37dea831ce5df0eb0a3bd051e689e68d84201682d807c4545f"

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
