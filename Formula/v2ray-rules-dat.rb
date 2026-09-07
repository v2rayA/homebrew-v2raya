class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609062324"

    $v2rayRulesDat_version = "202609062324"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609062324/geosite.dat"
    $sha_geosite = "25362d212e9baa1e503d45f5c23e81de5679c0319048f9ec73d1262e2b949e52"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609062324/geoip.dat"
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