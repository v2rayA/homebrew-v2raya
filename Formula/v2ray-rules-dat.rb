class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610282204"

    $v2rayRulesDat_version = "202610282204"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610282204/geosite.dat"
    $sha_geosite = "28f03a463ff51a1c8a1a839428628e745db21ba996c5b496bce384a8b0767a4e"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610282204/geoip.dat"
    $sha_geoip = "a6271d3c96361d96156e6d3f7cf1550ef21b00d2f951deb772f464db91e89ac5"

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