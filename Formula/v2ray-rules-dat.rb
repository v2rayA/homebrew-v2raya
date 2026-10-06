class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610052207"

    $v2rayRulesDat_version = "202610052207"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610052207/geosite.dat"
    $sha_geosite = "f574a55e779133682583ca8e8fd052f2a70d9d010431a5579cf1a6c93ef6e910"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610052207/geoip.dat"
    $sha_geoip = "391b522361c52804e486a98b53d97f3d9c1d3e4e4217bb34954774a0b456b9fd"

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