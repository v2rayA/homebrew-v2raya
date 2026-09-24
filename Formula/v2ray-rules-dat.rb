class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609240010"

    $v2rayRulesDat_version = "202609240010"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609240010/geosite.dat"
    $sha_geosite = "224798ccfaf4fb09be31b63c0807b2969641a74350902c76926a6c0e9d3347ba"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609240010/geoip.dat"
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