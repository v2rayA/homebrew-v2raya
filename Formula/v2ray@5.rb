class V2rayAT5 < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://www.v2fly.org/"
    license "MIT License"
    version "5.1.0"
 
    $url_linux_x64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-linux-64.zip"
    $sha_linux_x64 = "e670334a1734b37361f5a1f12d79e989944b0f9556322f1ae710c2db16528e6a"
    $url_macos_x64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-macos-64.zip"
    $sha_macos_x64 = "fe649ebe10d507d0f04db3eeaccb6363cffac1fc42e517d0e10f3fc16c6ef5cd"
    $url_macos_arm64 = "https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-macos-arm64-v8a.zip"
    $sha_macos_arm64 = "a916c2b1a041ad5771fa0153ceed24260e6b9e07e5f946caf80b949c699f44f4"
    if OS.linux?
      url $url_linux_x64
      sha256 $sha_linux_x64
    elsif Hardware::CPU.intel?
      url $url_macos_x64
      sha256 $sha_macos_x64
      else
      url $url_macos_arm64
      sha256 $sha_macos_arm64
    end

    resource "geoip" do
      url "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202210302212/geoip.dat"
      sha256 "98a5b0e79104419eeeb6451adf5c91ba9dd162aa8e0b79c53bef94313966a08a"
    end

    resource "geosite" do
      url "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202210302212/geosite.dat"
      sha256 "ce6afe0efe22aedacf34ea1b26d2993793c4264e8a9cc971108db96149b2ba23"
    end

    def install  
      bin.install "v2ray"
      pkgetc.install "config.json"
      resource("geoip").stage do
        pkgshare.install "geoip.dat"
      end
      resource("geosite").stage do
        pkgshare.install "geosite.dat"
      end
      (bin/"v2ray").write_env_script execpath,
      V2RAY_LOCATION_ASSET: "${V2RAY_LOCATION_ASSET:-#{pkgshare}}"
    end

    service do
      run [bin/"v2ray", "run", "-config", etc/"v2ray/config.json"]
      keep_alive true
    end
end
