# ios-mobile-inbox

## Setup
1. Cocoapods
```
pod 'EmarsysInbox', :git => 'https://github.com/emartech/ios-mobile-inbox.git'
```
2. Init EmarsysInboxController with new()
```swift
navigationController?.pushViewController(EmarsysInboxController.new(), animated: true)
```

## Configurable variables
You may customize the view with the static variables in `EmarsysInboxConfig` .
```swift
EmarsysInboxConfig.bodyForegroundColor = .black
```

```swift
var headerBackgroundColor: UIColor?

var headerForegroundColor: UIColor?

var bodyBackgroundColor: UIColor?

var bodyForegroundColor: UIColor?

var bodyTintColor: UIColor?

var bodyHighlightTintColor: UIColor?

var activityIndicatorColor: UIColor?

var favImageOff: UIImage?

var favImageOn: UIImage?
```

## Screenshots
![Sample](sample.png)

Star icons made by [Pixel perfect](https://www.flaticon.com/authors/pixel-perfect) from [www.flaticon.com](https://www.flaticon.com)
