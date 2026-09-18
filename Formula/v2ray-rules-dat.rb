class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609172350"

    $v2rayRulesDat_version = "202609172350"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609172350/geosite.dat"
    $sha_geosite = "e9d1384070a48fac2da09ff9058b9f8efc159cb7d30b948b2525bdc7d72683fe"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609172350/geoip.dat"
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