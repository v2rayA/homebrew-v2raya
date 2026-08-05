class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608042256"

    $v2rayRulesDat_version = "202608042256"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608042256/geosite.dat"
    $sha_geosite = "006cc1ebe84fd1b8cf4d57711d9fa7f000fcc6cb0128709fb0e3b11d2941f3a4"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608042256/geoip.dat"
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