class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202611262204"

    $v2rayRulesDat_version = "202611262204"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611262204/geosite.dat"
    $sha_geosite = "3f0a3587c23ad94855c839bf5429ffbd7aba752d14757f2ebc340cb262395624"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202611262204/geoip.dat"
    $sha_geoip = "9dc8e7de8db8300ce27b606f4a30632265713d2f33bcc568c0d2c44c825c8687"

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