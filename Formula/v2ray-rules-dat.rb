class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611102204"

    $v2rayRulesDat_version = "202611102204"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611102204/geosite.dat"
    $sha_geosite = "22bfa33ed2b511ad246dfed7114bfa92ae258fce2ede6a24e7320439103da3b4"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611102204/geoip.dat"
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