class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608202220"

    $v2rayRulesDat_version = "202608202220"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608202220/geosite.dat"
    $sha_geosite = "2a791fdb114a558974d1e1ced69c98656306998a18baf07cead8cade97a90fb8"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608202220/geoip.dat"
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