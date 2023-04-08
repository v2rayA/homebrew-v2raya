class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230408.r1332.2029149"
    
    $v2raya_version = "20230408.r1332.2029149"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4643824571/v2raya_linux_x64_unstable-20230408.r1332.2029149.zip"
    $sha_linux_x64 = "e7ca48608235e50884be4512551b2f8e67a7f47748b828e7475c9d0685041873"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4643824571/v2raya_darwin_x64_unstable-20230408.r1332.2029149.zip"
    $sha_macos_x64 = "c9c67aaeab5294db97039dc9fae53888d3a533fe6b6a9de199354c94f7ee8c22"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4643824571/v2raya_darwin_arm64_unstable-20230408.r1332.2029149.zip"
    $sha_macos_arm64 = "797c44a06384382c98229a9f77abaf0eafcaf349b1836bd701835dff9e247e3f"

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
