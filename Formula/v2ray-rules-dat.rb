class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607232250"

    $v2rayRulesDat_version = "202607232250"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607232250/geosite.dat"
    $sha_geosite = "aaba3630e243e4a52f1eb33e185e00f2edaf532f2adddf9168716d3cec14cd48"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607232250/geoip.dat"
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