class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609052329"

    $v2rayRulesDat_version = "202609052329"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609052329/geosite.dat"
    $sha_geosite = "6fb14357520e6d9e8ba3e5755ddabadd6e902c7a7d9f21e5fe56b9414802e370"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609052329/geoip.dat"
    $sha_geoip = "4149e607530f91da697bad4696f8c59f0a475af38e69405e4124438c9886c721"

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