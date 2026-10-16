class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610152206"

    $v2rayRulesDat_version = "202610152206"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610152206/geosite.dat"
    $sha_geosite = "9d951dbf2fcbabd04cd18051a6679eaa1da12566ddf5aa613e53eaee88ae7dc7"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610152206/geoip.dat"
    $sha_geoip = "1931cec183daad70aa84c1ff7559d316c94cd3e67ddba4b8fddde125f10068bc"

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