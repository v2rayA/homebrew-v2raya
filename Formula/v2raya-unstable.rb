class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230509.r1336.292a892"
    
    $v2raya_version = "20230509.r1336.292a892"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4926473370/v2raya_linux_x64_unstable-20230509.r1336.292a892.zip"
    $sha_linux_x64 = "9d63cd019bf7f7d741784f1ae361c9bbadd130b3ac2a302d0ae26352c1aa6b69"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4926473370/v2raya_darwin_x64_unstable-20230509.r1336.292a892.zip"
    $sha_macos_x64 = "5b1f6009aa916ac00ee8affac761f6117d6b3bb028a5f06dd75625e988d79e64"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4926473370/v2raya_darwin_arm64_unstable-20230509.r1336.292a892.zip"
    $sha_macos_arm64 = "3593206e04a9f546335e4fbc05e78620c7ea6aa39cdfd8bab9733de664f538ba"

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
