class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610242205"

    $v2rayRulesDat_version = "202610242205"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610242205/geosite.dat"
    $sha_geosite = "e16ee9af893247f9c8b15c5259e5c0a6ae491b85ee351c22f1954e696ebb8997"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610242205/geoip.dat"
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