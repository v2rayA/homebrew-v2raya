class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230322.r1322.1993777"
    
    $v2raya_version = "20230322.r1322.1993777"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4490020007/v2raya_linux_x64_unstable-20230322.r1322.1993777.zip"
    $sha_linux_x64 = "ee330dfe2f17be20a96916b063cc9ea8ada583089904d19c6cc1ce1e29a494d4"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4490020007/v2raya_darwin_x64_unstable-20230322.r1322.1993777.zip"
    $sha_macos_x64 = "3a34725ece0e0c18ecc4336a5d97ffc879c7c430c138a56652b0f998b43bcebc"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/4490020007/v2raya_darwin_arm64_unstable-20230322.r1322.1993777.zip"
    $sha_macos_arm64 = "279f544908f9dcbd55cb2bdef8b2b614cee17159d507496b7bdd321aa2838ce5"

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
        mv
      bin.install "v2raya_#{$os_type}_unstable_#{version}" => "v2raya-unstable"
      system "echo", "v2raya-unstable installed, please don't run both v2raya and v2raya-unstable service at the same time."
      system "echo", "or write launchd's plist file yourself to specify ports used by v2raya-unstable."
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-unstable.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya-unstable", "--lite"]
      keep_alive true
    end
end
