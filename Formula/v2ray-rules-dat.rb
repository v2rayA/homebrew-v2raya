class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610082207"

    $v2rayRulesDat_version = "202610082207"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610082207/geosite.dat"
    $sha_geosite = "cc5f00ba417ee56daea66d160e8cf8704fbfb2a6af8ae27fd64017cb1ebcf034"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610082207/geoip.dat"
    $sha_geoip = "116cc0f03d48991962f7f9cdbbcf53d45d89777f9c3cd1a663210853e5df6093"

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