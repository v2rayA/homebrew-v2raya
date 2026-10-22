class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202610212206"

    $v2rayRulesDat_version = "202610212206"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610212206/geosite.dat"
    $sha_geosite = "77cc7cc99d8a6f606a8c266308501e26fd7038b9c0508db0e551b933c41cdedf"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202610212206/geoip.dat"
    $sha_geoip = "4a1b1eddabf5614fa51dd93ac0498856cb82dd65933cd6d6d5890d8c7bb5e902"

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