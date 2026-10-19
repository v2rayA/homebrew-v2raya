class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610182205"

    $v2rayRulesDat_version = "202610182205"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610182205/geosite.dat"
    $sha_geosite = "3691de3874692fc8709686998c7627d030df3910d21f3d68232aaa0f1249dd2d"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610182205/geoip.dat"
    $sha_geoip = "010bfc2e353c5e34e23156004944444ca260bae999e73171bdd7974056557959"

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