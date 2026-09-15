class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609151013"

    $v2rayRulesDat_version = "202609151013"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609151013/geosite.dat"
    $sha_geosite = "02e2639af87411fc7dcd31034b7f9248bae3bb1b06c8b4fb5c5162d9181777fe"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609151013/geoip.dat"
    $sha_geoip = "45325fee1555c8bf04115100694ce8429b88c9bb3b3548abcfd236a1c8ea146f"

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