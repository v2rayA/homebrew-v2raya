class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608290326"

    $v2rayRulesDat_version = "202608290326"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608290326/geosite.dat"
    $sha_geosite = "4b60c1ba2056def3956e70017e04f2041198019223d2b9ca394e3b93b7460976"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608290326/geoip.dat"
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