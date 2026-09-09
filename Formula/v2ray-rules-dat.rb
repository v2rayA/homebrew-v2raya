class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609082347"

    $v2rayRulesDat_version = "202609082347"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609082347/geosite.dat"
    $sha_geosite = "110be548fd2c2d84249310842667f996e01ab5c753d526717a0f434a5a08e5ea"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609082347/geoip.dat"
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