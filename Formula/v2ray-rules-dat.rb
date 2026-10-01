class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610010125"

    $v2rayRulesDat_version = "202610010125"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610010125/geosite.dat"
    $sha_geosite = "ff2daae83265b9892a0cab7a7a6a8ac3d7ed29e34527511f795e3322c9122671"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610010125/geoip.dat"
    $sha_geoip = "3e21484fe4b72d788439e6f16a29bf7967892dd9e82f17e087608837cb260639"

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