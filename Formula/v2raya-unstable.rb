class V2rayaUnstable < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "20230802.r1350.5ab2def"
    
    $v2raya_version = "20230802.r1350.5ab2def"
    $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5739966562/v2raya_linux_x64_unstable-20230802.r1350.5ab2def.zip"
    $sha_linux_x64 = "c04fb273a35b98394cdc745ebd321577b1376b4594afedf140b4a1839a8e727d"
    $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5739966562/v2raya_darwin_x64_unstable-20230802.r1350.5ab2def.zip"
    $sha_macos_x64 = "f9a1e9a510a8b23241567acd44681942102f34b93fbdd0a9f361ad014a8bbb53"
    $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/5739966562/v2raya_darwin_arm64_unstable-20230802.r1350.5ab2def.zip"
    $sha_macos_arm64 = "8970ab4dd5b48d129b3182ce8945ea64818d26e0d0ad571d708b468acbc2dbb0"

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
