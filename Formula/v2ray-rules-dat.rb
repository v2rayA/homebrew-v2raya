class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607142252"

    $v2rayRulesDat_version = "202607142252"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607142252/geosite.dat"
    $sha_geosite = "bbb010787b0d1018e91deea50a122f9cae33bcab2c08029011b8f9d7c77b1d89"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607142252/geoip.dat"
    $sha_geoip = "83797719facc092e210f8f8e0e5e0b0bdfe06ac90a3a4a3d6a6ab2d781a917ae"

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