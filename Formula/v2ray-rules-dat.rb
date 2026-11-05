class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611042203"

    $v2rayRulesDat_version = "202611042203"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611042203/geosite.dat"
    $sha_geosite = "916fea0cea925cc47f09001dfac652d5e8edb6db69ff13ad68e2b4ac9e8ecc1b"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611042203/geoip.dat"
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