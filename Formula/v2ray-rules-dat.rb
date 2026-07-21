class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607202253"

    $v2rayRulesDat_version = "202607202253"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607202253/geosite.dat"
    $sha_geosite = "32ef2379df257042dbf9d3e6779b42f1533ffece918a009470f4851ff2277923"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607202253/geoip.dat"
    $sha_geoip = "af332ab88eb4bb15e3cd10f03f5542e90655ee4bd5bf0e23949cfbd1e46bc20f"

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