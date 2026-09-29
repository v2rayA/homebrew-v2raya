class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609290124"

    $v2rayRulesDat_version = "202609290124"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609290124/geosite.dat"
    $sha_geosite = "a4b58274fe6bc9dcc28d12b5100a759c0de442105da5e06eb26cfcccdc3d9892"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609290124/geoip.dat"
    $sha_geoip = "3cf2236c19063c1c80803368cca5ff589c5033129fdf9ba154230c689b81fc2a"

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