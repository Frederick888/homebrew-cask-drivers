cask 'asix-mcs783x' do
  version '1.1.0_20141202'
  sha256 'd86bdf6107cec7d3990f6967a5be782f7945cb722f22789cb04051514ba87a10'

  module Utils
    def self.basename(version)
      "MCS783x_Mac_OSX_10.5_to_10.10_driver_v#{version}"
    end
  end

  url "https://www.asix.com.tw/FrootAttach/driver/#{Utils.basename(version)}.zip"
  name 'ASIX MCS7830/7832 USB to Ethernet Controller Driver'
  homepage 'https://www.asix.com.tw/products.php?op=pItemdetail&PItemID=108;71;101&PLine=71'

  depends_on macos: '<= :yosemite'
  container nested: "#{Utils.basename(version)}/MCS7830_v#{version.major_minor_patch}.dmg"

  pkg "MCS7830 v#{version.major_minor_patch}.pkg"

  postflight do
    system_command '/sbin/kextload',
                   args: ['-b', 'com.asix.driver.moschipUsbEthernet'],
                   sudo: true
  end

  uninstall script:  'uninstal driver', # The "uninstal" (one "l") isn't a typo, that's the exact filename
            pkgutil: 'asix.com.moschipUsbEthernet.pkg'
end
