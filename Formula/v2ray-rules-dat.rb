class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608102230"

    $v2rayRulesDat_version = "202608102230"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608102230/geosite.dat"
    $sha_geosite = "0f034c1ef15ed93146c685aeb8359af99994c40a742390d0324d5fef230eeaf6"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608102230/geoip.dat"
    $sha_geoip = "53dc90b50877d2ed974ea81fb0fbdcbac84e189c0ac7fdcab7a966bb5e36b6e6"

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