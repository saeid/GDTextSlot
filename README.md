# GDTextSlot
Text slot control for code/text input. Easy setup with Storyboard / Code.

![slotview](https://user-images.githubusercontent.com/9967486/36479624-625fbe3c-171a-11e8-8f9e-4c39ee0f4f8d.gif)

------
------

### Requirments
- Xcode 9+
- Swift 5
- iOS 9+
-----

### Installation

## Manual
drag `GDTextSlot.swift` to your project and use!

## Cocoapods
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
pod 'GDTextSlot'
end
```
    pod update
    pod install

-----

### Usage

## Code
```swift
let frame = CGRect(x: 0, y: 0, width: 300, height: 60)
let slotView = GDTextSlot(frame: frame)
slotView.delegate = self
view.addSubview(slotView)
```

Set Properties
```swift
// Activate slot
slotView.becomeFirstResponder()

// Set keyboard type
slotView.keyboard = .default

// Set number of slots. default is 4
slotView.numberOfSlots = 6

// Set space between slots. default is 30
slotView.baseWidth = 40

// Set text slot placeholder. Default is ___
slotView.placeholder = *
```

Inherit `GDTextSlotDelegate`
    class ViewController: UIViewController, GDTextSlotDelegate

```swift
func onTextEntered(_ slotView: GDTextSlot, _ finalText: String){
    print(finalText)
}
```

## Storyboard
1) Add `UIView` to storyboard, set custom class to `GDTextSlot`
2) Set attributes with `Attribute Inspector`

Run!
