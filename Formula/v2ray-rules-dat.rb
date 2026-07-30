class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607292255"

    $v2rayRulesDat_version = "202607292255"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607292255/geosite.dat"
    $sha_geosite = "9e0b50efeed328ea5b6d827922635bc6cc1f0154484023af579720dbb8fd32d0"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607292255/geoip.dat"
    $sha_geoip = "7150b22213591be29aa081b14b4fdc80bfa44540d07cec42c43abe1477a2b640"

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