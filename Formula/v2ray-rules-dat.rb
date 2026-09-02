class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609012343"

    $v2rayRulesDat_version = "202609012343"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609012343/geosite.dat"
    $sha_geosite = "81f0437edc89f76df985904c24468304b2fdc51249a759f54758b019a3d918b4"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609012343/geoip.dat"
    $sha_geoip = "0d5d2ba0c5a5c58027fd1347a6afd57c9470799b6bb3cbc274fd4657ed8de382"

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