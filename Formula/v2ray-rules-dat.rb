class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202607152253"

    $v2rayRulesDat_version = "202607152253"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607152253/geosite.dat"
    $sha_geosite = "1f4ce9b3b037db161745c7ba07b1bfafab36d99b0a5e515912eb4f7605b0bb07"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202607152253/geoip.dat"
    $sha_geoip = "07afbae04519eb7ca07fed75bd39b48a5c74d6b4c0fbcccb0e671df9ff54e6f8"

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