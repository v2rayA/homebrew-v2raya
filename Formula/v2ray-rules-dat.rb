class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609132350"

    $v2rayRulesDat_version = "202609132350"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609132350/geosite.dat"
    $sha_geosite = "26914f6992dfc0d71ef2e3110a01571068b15d2f4ae343a0a5afbc1c9e4e5590"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609132350/geoip.dat"
    $sha_geoip = "45325fee1555c8bf04115100694ce8429b88c9bb3b3548abcfd236a1c8ea146f"

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