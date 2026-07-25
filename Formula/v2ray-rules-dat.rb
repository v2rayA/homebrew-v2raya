class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607242256"

    $v2rayRulesDat_version = "202607242256"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607242256/geosite.dat"
    $sha_geosite = "abf411f4141e5c77cb202f1d0d3b16230617d2a1b497eb3f5742dc4fe1898da7"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607242256/geoip.dat"
    $sha_geoip = "cdf411fce977a1f48adb6a3b224e3e2bd7eccfcd4d6e2e30c6dc443f1a0e8e52"

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