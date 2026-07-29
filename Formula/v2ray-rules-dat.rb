class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607282253"

    $v2rayRulesDat_version = "202607282253"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607282253/geosite.dat"
    $sha_geosite = "7ba5768a73e86f1382349badd26d6f21f8b74fd7280d473fd636ad623f771b14"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607282253/geoip.dat"
    $sha_geoip = "4de49c5de6f06a93d83d0502e10f1fb82359c23211f8523d38341c7ac8d0eb18"

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