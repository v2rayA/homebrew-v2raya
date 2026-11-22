class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611212204"

    $v2rayRulesDat_version = "202611212204"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611212204/geosite.dat"
    $sha_geosite = "95f47f3b6a848db9979e8bd8daff9b213b7b159b803519c86038ac30aab2b5c2"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611212204/geoip.dat"
    $sha_geoip = "d4ec4c5e5d5a38c1399964ea9fd8c94288426a3b31b483904b67819fc07f4466"

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