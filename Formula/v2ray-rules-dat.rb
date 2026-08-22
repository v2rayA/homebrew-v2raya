class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608212217"

    $v2rayRulesDat_version = "202608212217"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608212217/geosite.dat"
    $sha_geosite = "b392a98a323777deab59d8208e856df09cf96f3a76d2869eb7a8e5289bc5d9f4"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608212217/geoip.dat"
    $sha_geoip = "8ebcb11333f7deed4bf2740f2ce3249aa8997ef03d437150c7ae373c011cd72a"

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