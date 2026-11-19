class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611182204"

    $v2rayRulesDat_version = "202611182204"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611182204/geosite.dat"
    $sha_geosite = "268f30619cfe5db5a925766bf966045f23b58b9a57bbc00c00396eb548011814"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611182204/geoip.dat"
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