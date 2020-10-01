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
```

```swift
var headerForegroundColor: UIColor?
```

```swift
var bodyBackgroundColor: UIColor?
```

```swift
var bodyForegroundColor: UIColor?
```

```swift
var bodyTintColor: UIColor?
```

```swift
var bodyHighlightTintColor: UIColor?
```

```swift
var activityIndicatorColor: UIColor?
```

```swift
var favImageOff: UIImage?
```

```swift
var favImageOn: UIImage?
```

```swift
var notOpenedViewColor: UIColor?
```

```swift
var defaultImage: UIImage?
```

```swift
var highPriorityImage: UIImage?
```

## Screenshots
![Sample](sample.png)
