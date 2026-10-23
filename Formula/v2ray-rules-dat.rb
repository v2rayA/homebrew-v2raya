class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610222206"

    $v2rayRulesDat_version = "202610222206"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610222206/geosite.dat"
    $sha_geosite = "cfb4e3be914b5c887b9f67807171ec2887d34690252e4f011266d60fc6849602"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610222206/geoip.dat"
    $sha_geoip = "a21bacd4e378bfec3bfb5426c08fd995d78ed31f6a44180c9449a61be185f85f"

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