class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610172205"

    $v2rayRulesDat_version = "202610172205"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610172205/geosite.dat"
    $sha_geosite = "15272a5503020d67199bec2e5b1c26b8de98ed0c9fe65d390a5ecd66acf1b430"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610172205/geoip.dat"
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