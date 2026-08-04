class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608032254"

    $v2rayRulesDat_version = "202608032254"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608032254/geosite.dat"
    $sha_geosite = "8c3a825b1a7d09f627de10263b21008b8a48dee10794f42caf1927928fec74da"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608032254/geoip.dat"
    $sha_geoip = "6ba63d75f307d16a81ae09406ddcf2779fa75cb642d4aae59613370d62d33509"

    url $url_geosite
    sha256 $sha_geosite

    resource "geoip.dat" do
      url $url_geoip
      sha256 $sha_geoip
    end

    def install
      pkgshare.install "geosite.dat"
      resource("geoip.dat").stage do
        pkgshare.install "geoip.dat"
      end
    end
end