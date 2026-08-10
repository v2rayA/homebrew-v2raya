class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608092223"

    $v2rayRulesDat_version = "202608092223"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608092223/geosite.dat"
    $sha_geosite = "471a22237ae0fd4be4e1b54eb9b4a389edf4b07e454acba7e34576f8fee63f40"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608092223/geoip.dat"
    $sha_geoip = "53dc90b50877d2ed974ea81fb0fbdcbac84e189c0ac7fdcab7a966bb5e36b6e6"

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