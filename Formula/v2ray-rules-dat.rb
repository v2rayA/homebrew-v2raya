class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608242219"

    $v2rayRulesDat_version = "202608242219"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608242219/geosite.dat"
    $sha_geosite = "c9a47d1a83134e3dcb57d5a3457408c3ed426ab0430718c85a44d3223aaad075"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608242219/geoip.dat"
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