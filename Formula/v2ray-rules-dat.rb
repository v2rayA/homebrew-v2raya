class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610092207"

    $v2rayRulesDat_version = "202610092207"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610092207/geosite.dat"
    $sha_geosite = "79d15a5bd8205d83c377fcfde394500db762b2b400feff24612834e528a111cb"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610092207/geoip.dat"
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