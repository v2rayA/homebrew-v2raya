class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611062204"

    $v2rayRulesDat_version = "202611062204"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611062204/geosite.dat"
    $sha_geosite = "054409f16eeafc0ad558fea815ab812a0ed8c2d80d92a2043c8366ebb116d1b5"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611062204/geoip.dat"
    $sha_geoip = "90b78ab861c1cdc3f871f305f9ceedfb8d6d6329e3a40295e6773e057297384c"

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