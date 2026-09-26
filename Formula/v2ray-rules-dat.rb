class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609260019"

    $v2rayRulesDat_version = "202609260019"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609260019/geosite.dat"
    $sha_geosite = "678f64502f148c4e270c4537f8c5c242f41271846e5a8fff1ba4b05fdc32b512"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609260019/geoip.dat"
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