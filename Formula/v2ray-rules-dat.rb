class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611032326"

    $v2rayRulesDat_version = "202611032326"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611032326/geosite.dat"
    $sha_geosite = "0b2a5c5b82b031f6b079f9a5b47814914f3fc94d6c689d081b8634624cfe1d55"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611032326/geoip.dat"
    $sha_geoip = "06c1d50d0013af57ffe78c5af93f0dc6aa998890f3ee231393816f9117810c4a"

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