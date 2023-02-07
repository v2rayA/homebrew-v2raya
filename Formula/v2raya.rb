class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.0.1-2"
    
    $v2rayA_version = "2.0.1-2"
    $url_linux_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-2/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "A3CF5EC67836483CE49C927D1CF81C04A36F99DDCF4DA092AAC1FC3C62A8F59F"
    $url_macos_x64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-2/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "79EFD323D39955FB869DA2E931F4FDE8ADA53BCEB801C1B5E6BCE8AFC7E558B8"
    $url_macos_arm64 = "https://github.com/v2rayA/homebrew-v2raya/releases/download/2.0.1-2/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "46EB0783B4D211B5684AC8DFAECF78D324F83A7E3F875A3EACFE13543DBE907E"
    $Loyalsoldier_version = "202302062209"
    $url_geoip_only_cn_private = "https://github.com/v2fly/geoip/releases/download/202302020047/geoip-only-cn-private.dat"
    $sha_geoip_only_cn_private = "1bf20b18ac663b7f536f827404fb278e482dd431744b847d4124b282254f6979"
    $url_LoyalsoldierSite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202302062209/geosite.dat"
    $sha_LoyalsoldierSite = "9b88eb07aac6777b6d1d6f32a1b0b2717022a49d592dc712c1f410f4a3dd62fa"
    $url_LoyalsoldierIP = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202302062209/geoip.dat"
    $sha_LoyalsoldierIP = "b76839ef53aa05e000bad8efa78ddf433eea8df427c0bafac42c8a6e7f2ac821"

    if OS.linux?
      url $url_linux_x64
      sha256 $sha_linux_x64
    elsif Hardware::CPU.intel?
      url $url_macos_x64
      sha256 $sha_macos_x64
      else
      url $url_macos_arm64
      sha256 $sha_macos_arm64
    end

    resource "geoip" do
      url $url_LoyalsoldierIP
      sha256 $sha_LoyalsoldierIP
    end
  
    resource "geoip-only-cn-private" do
      url $url_geoip_only_cn_private
      sha256 $sha_geoip_only_cn_private
    end
  
    resource "geosite" do
      url $url_LoyalsoldierSite
      sha256 $sha_LoyalsoldierSite
    end

    depends_on "v2ray5"

    def install

      resource("geoip").stage do
        pkgshare.install "geoip.dat"
        pkgshare.install "geoip.dat" => "LoyalSoldierIP.dat"
      end
  
      resource("geoip-only-cn-private").stage do
        pkgshare.install "geoip-only-cn-private.dat"
      end
  
      resource("geosite").stage do
        pkgshare.install "geosite.dat" => "geosite.dat"
        pkgshare.install "geosite.dat" => "LoyalSoldierSite.dat"
      end

      bin.install "v2raya"
    
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray5", V2RAYA_LOG_FILE: "/tmp/v2raya.log", V2RAYA_V2RAY_ASSETSDIR: "#{HOMEBREW_PREFIX}/share/v2raya"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
