class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609192350"

    $v2rayRulesDat_version = "202609192350"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609192350/geosite.dat"
    $sha_geosite = "6fc125d4bab8cbfee8341b77f1024ec4faa36cd3ce854ff40a462ac36d88ed39"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609192350/geoip.dat"
    $sha_geoip = "f3370cf391831bb01e1e662df88596164d136e7d9f81a91c00bae26587e02d72"

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