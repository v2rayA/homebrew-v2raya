class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609032344"

    $v2rayRulesDat_version = "202609032344"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609032344/geosite.dat"
    $sha_geosite = "c9a73e90969e292487ff11545708f9a744716c7d4a3fa1aa6dd7c098d8991fc3"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609032344/geoip.dat"
    $sha_geoip = "2c2272aedff90dc25353e4d35df3d4a96c8ad77a65090e0433758ebd148382dd"

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