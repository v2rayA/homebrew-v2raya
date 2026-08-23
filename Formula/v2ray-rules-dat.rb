class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608222215"

    $v2rayRulesDat_version = "202608222215"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608222215/geosite.dat"
    $sha_geosite = "919c19a0918ff774a9f0307bb8de56f17636d12b5bffbc5167bbfd30f7970bbd"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608222215/geoip.dat"
    $sha_geoip = "8ebcb11333f7deed4bf2740f2ce3249aa8997ef03d437150c7ae373c011cd72a"

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