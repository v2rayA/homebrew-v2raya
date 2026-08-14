class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608132234"

    $v2rayRulesDat_version = "202608132234"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608132234/geosite.dat"
    $sha_geosite = "174c0a0571a86c9addff6c39f240d28fb1dd1643a7a969fd7b47cbfbbd1e8a95"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608132234/geoip.dat"
    $sha_geoip = "b406dd3759037188b0674b110dcaf33664a699c0518152d0ca0d9023fc774c6b"

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