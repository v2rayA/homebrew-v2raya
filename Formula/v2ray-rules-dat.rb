class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610122207"

    $v2rayRulesDat_version = "202610122207"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610122207/geosite.dat"
    $sha_geosite = "032108de31922356df8fea422323bca7ada1ffcf3b73064ecd8e86e520a241cf"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610122207/geoip.dat"
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