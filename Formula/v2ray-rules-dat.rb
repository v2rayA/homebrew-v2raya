class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610162206"

    $v2rayRulesDat_version = "202610162206"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610162206/geosite.dat"
    $sha_geosite = "8474140bc89940897ee2b629be8fc92f34a496bd32e45829605d17715f4340d6"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610162206/geoip.dat"
    $sha_geoip = "010bfc2e353c5e34e23156004944444ca260bae999e73171bdd7974056557959"

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