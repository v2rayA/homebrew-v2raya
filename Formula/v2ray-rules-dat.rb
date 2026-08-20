class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608192217"

    $v2rayRulesDat_version = "202608192217"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608192217/geosite.dat"
    $sha_geosite = "ca859f452bdb35cb32a0bab47a166ca2000e69a8a9641d92ed3847d7e2573369"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608192217/geoip.dat"
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