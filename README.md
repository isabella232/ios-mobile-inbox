# ios-mobile-inbox

![Sample](sample.png)

## Setup
1. Copy the folder EmarsysInbox into your project
2. Init EmarsysInboxController with new()
```navigationController?.pushViewController(EmarsysInboxController.new(), animated: true)
```

## Configurable variables
You may customize the view with the static variables in `EmarsysInboxConfig` .
```EmarsysInboxConfig.bodyForegroundColor = .black
```
var headerBackgroundColor: UIColor?
var headerForegroundColor: UIColor?
var bodyBackgroundColor: UIColor?
var bodyForegroundColor: UIColor?
var bodyTintColor: UIColor?
var bodyHighlightTintColor: UIColor?
var activityIndicatorColor: UIColor?
var favImageOff: UIImage?
var favImageOn: UIImage?

## ToDo
Make the project available on Cocoapod
