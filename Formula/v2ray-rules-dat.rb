class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610262207"

    $v2rayRulesDat_version = "202610262207"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610262207/geosite.dat"
    $sha_geosite = "581e8886f032bb3fbff79bfd1b3a22f3e2ab76bca5c31db030e692339cc1ee7e"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610262207/geoip.dat"
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