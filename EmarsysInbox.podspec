Pod::Spec.new do |spec|

  spec.name         = "EmarsysInbox"
  spec.version      = "1.0.0"
  spec.summary      = "Emarsys Inbox"
  spec.homepage     = "https://github.com/emartech/ios-mobile-inbox"
  spec.license      = "Mozilla Public License 2.0"
  spec.author       = { "Emarsys Technologies" => "mobile.engineers@emarsys.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/emartech/ios-mobile-inbox.git", :tag => "#{spec.version}" }
  spec.source_files = [ "EmarsysInbox" ]
  spec.resources    = [ "EmarsysInbox/**/*.{storyboard,xcassets}" ]

  spec.dependency "EmarsysSDK"

end
