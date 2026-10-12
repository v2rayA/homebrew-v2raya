class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610112207"

    $v2rayRulesDat_version = "202610112207"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610112207/geosite.dat"
    $sha_geosite = "8ba3b9f1731b3626c7bd11e97f6eadf54e654ca8523584e1b71b4df8eb4dd4c2"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610112207/geoip.dat"
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