class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609092346"

    $v2rayRulesDat_version = "202609092346"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609092346/geosite.dat"
    $sha_geosite = "5193ed098d950b91ebfe7d40b91b298e5ac9f0f69aa2698c757bee2aceee8c29"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609092346/geoip.dat"
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