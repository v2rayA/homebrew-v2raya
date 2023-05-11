class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230511.r1342.6969922"
    
    $v2raya_version = "20230511.r1342.6969922"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4948686137/v2raya_linux_x64_unstable-20230511.r1342.6969922.zip"
    $sha_linux_x64 = "a2bcaa7de9189f1d1a089060a75ca1e10b084914bfb3222ae5d4d34fd96e7222"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4948686137/v2raya_darwin_x64_unstable-20230511.r1342.6969922.zip"
    $sha_macos_x64 = "286f885bbb0adc3e1461482f16025d83f9f248a83be88cf1dae4eaa577cba8f6"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4948686137/v2raya_darwin_arm64_unstable-20230511.r1342.6969922.zip"
    $sha_macos_arm64 = "c6aa8a881c832e23d77427db538ce44ec0dc8d9bb668be9333fd0af1bee39163"

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
