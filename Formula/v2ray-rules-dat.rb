class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609220030"

    $v2rayRulesDat_version = "202609220030"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609220030/geosite.dat"
    $sha_geosite = "a7f939cd7160f0c1955508a37f9ce1d4aad8c28b99e115160528094b2f440241"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609220030/geoip.dat"
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