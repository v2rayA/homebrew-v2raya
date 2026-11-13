class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611122204"

    $v2rayRulesDat_version = "202611122204"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611122204/geosite.dat"
    $sha_geosite = "f5bf5d977840be4b9e73856b20f8d6dc7ef72285330c5f270d1d64cc2bf7982f"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611122204/geoip.dat"
    $sha_geoip = "304ac8a1cbcc8166e4f5a4f32955e4d0fb77a1bd713583e371b30ee27f3659d8"

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