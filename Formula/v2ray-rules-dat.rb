class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608082221"

    $v2rayRulesDat_version = "202608082221"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608082221/geosite.dat"
    $sha_geosite = "8481629701db6f547d4e1e1c4303c396588b9931de5d523dfb9fc9ab6c036024"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608082221/geoip.dat"
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