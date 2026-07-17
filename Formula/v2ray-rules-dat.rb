class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607170049"

    $v2rayRulesDat_version = "202607170049"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607170049/geosite.dat"
    $sha_geosite = "f330a18c5135d110bc7740114f57c1974c577c0718addb2dab69e4815521fcb8"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607170049/geoip.dat"
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