class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202608072228"

    $v2rayRulesDat_version = "202608072228"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608072228/geosite.dat"
    $sha_geosite = "5ee72bd52946bf14b1a2de6c09274a89d75a324f68598ce85ea9286da525269f"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202608072228/geoip.dat"
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