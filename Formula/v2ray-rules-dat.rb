class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608022250"

    $v2rayRulesDat_version = "202608022250"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608022250/geosite.dat"
    $sha_geosite = "833992dc7cec47a5b0b8492219c09690362371933931ac9af40a729897579824"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608022250/geoip.dat"
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