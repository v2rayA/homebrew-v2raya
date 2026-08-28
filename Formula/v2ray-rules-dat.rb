class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608280554"

    $v2rayRulesDat_version = "202608280554"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608280554/geosite.dat"
    $sha_geosite = "32ee712fdab10e7f55ef941f722eb59cfe18ee66c145111ea7f3a88a6813459d"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608280554/geoip.dat"
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