class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610312203"

    $v2rayRulesDat_version = "202610312203"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610312203/geosite.dat"
    $sha_geosite = "de0ed52484ee4e793b63e3f9d9de9677e90b289483d96d94fa7f2d7503bdced0"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610312203/geoip.dat"
    $sha_geoip = "fbf747a085be25eb61ecac8c27140b4ab0bf8181af6fdb104caa325bd93cf117"

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