class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608070127"

    $v2rayRulesDat_version = "202608070127"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608070127/geosite.dat"
    $sha_geosite = "a4e23eadbfb4880bc3070e1434a33b61927a2c77bc1a597f0f0347be28efb5ea"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608070127/geoip.dat"
    $sha_geoip = "53dc90b50877d2ed974ea81fb0fbdcbac84e189c0ac7fdcab7a966bb5e36b6e6"

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