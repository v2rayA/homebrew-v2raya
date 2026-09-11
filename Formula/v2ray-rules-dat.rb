class V2rayRulesDat < Formula
    desc "Enhanced V2Ray rules dat files"
    homepage "https://github.com/loyalsoldier/v2ray-rules-dat"
    license "GPL-3.0-only"
    version "202609102337"

    $v2rayRulesDat_version = "202609102337"
    $url_geosite = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609102337/geosite.dat"
    $sha_geosite = "fb3490223c8c5211945bfae41b437a27afd813f25041d2227b99f06c7e51100b"
    $url_geoip = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202609102337/geoip.dat"
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