# GDTextSlot
A customizable control for code/text input. Easy setup with Storyboard and attributes inspector or Code.

![slotview](https://user-images.githubusercontent.com/9967486/36479624-625fbe3c-171a-11e8-8f9e-4c39ee0f4f8d.gif)

------
------

### Requirments
- Xcode 9+
- Swift 5
- iOS 9+
-----

# Installation
## Manual
drag `GDTextSlot.swift` to your project!

## Cocoapods
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'GDTextSlot'
end
```
    pod install


# Usage

## Code
```swift
let frame = CGRect(x: 0, y: 0, width: 300, height: 60)
let slotView = GDTextSlot(frame: frame)
slotView.delegate = self
view.addSubview(slotView)
```

Set Properties
```swift
// Automatically activate text slot and show keyboard
// Or it will be activated when it's tapped
slotView.becomeFirstResponder()

// Set keyboard type -- Default is .numberPad
slotView.keyboard = .default

// Set number of slots -- Default is 4
slotView.numberOfSlots = 6

// Set space between slots -- Default is 50
slotView.baseWidth = 40

// Set text slot placeholder. Default is ___
slotView.placeholder = *

// Set custom font for the text
slotView.textFont = UIFont
```

Conform to `GDTextSlotDelegate`

```swift
func onTextEntered(_ slotView: GDTextSlot, _ finalText: String){
    print(finalText)
}
```

## Storyboard
1) Add a `UIView` and set its custom class to `GDTextSlot`
2) Set attributes with `Attributes inspector`

Run!
