class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611242204"

    $v2rayRulesDat_version = "202611242204"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611242204/geosite.dat"
    $sha_geosite = "569c6e1ad7cfec7e5e56879acf1672671ad1085b8cfdd25b9e14cef37f0219d2"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611242204/geoip.dat"
    $sha_geoip = "d4ec4c5e5d5a38c1399964ea9fd8c94288426a3b31b483904b67819fc07f4466"

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