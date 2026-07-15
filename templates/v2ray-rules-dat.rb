class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "TheRealVersion"

    $v2rayRulesDat_version = "TheRealVersion"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/TheRealVersion/geosite.dat"
    $sha_geosite = "RealSha256_Geosite"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/TheRealVersion/geoip.dat"
    $sha_geoip = "RealSha256_Geoip"

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