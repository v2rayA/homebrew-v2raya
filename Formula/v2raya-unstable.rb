class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230330.r1326.41bafe0"
    
    $v2raya_version = "20230330.r1326.41bafe0"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4564878623/v2raya_linux_x64_unstable-20230330.r1326.41bafe0.41bafe0.zip"
    $sha_linux_x64 = "c4ae7f1fd8f0da771743880ce3878b5c570cbc59f53a4d8c3b5e94ea5e92e644"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4564878623/v2raya_darwin_x64_unstable-20230330.r1326.41bafe0.41bafe0.zip"
    $sha_macos_x64 = "ff828b36542f312049448b321ab0ac7c9db8e9f1fa8f207eeb3243d86d96ad2a"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4564878623/v2raya_darwin_arm64_unstable-20230330.r1326.41bafe0.41bafe0.zip"
    $sha_macos_arm64 = "bd5b576406acd619de264b5f3c4943db6effb2c8fd12b4a58351e0a716374300"

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
