class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608182216"

    $v2rayRulesDat_version = "202608182216"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608182216/geosite.dat"
    $sha_geosite = "24c06bb4e16b0af0d8ace68ed051b91aab4d9ee16a0fb3161e293df6a0c92d44"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608182216/geoip.dat"
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