class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607312254"

    $v2rayRulesDat_version = "202607312254"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607312254/geosite.dat"
    $sha_geosite = "1f3a743e8e30152a870a1674792af3976361436dcb1f510a43c499d430f6b13f"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607312254/geoip.dat"
    $sha_geoip = "6ba63d75f307d16a81ae09406ddcf2779fa75cb642d4aae59613370d62d33509"

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