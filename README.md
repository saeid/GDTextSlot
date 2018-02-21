# GDTextSlot
Simple component for code input texts with easy setup and inspector support.

![slotview](https://user-images.githubusercontent.com/9967486/36477977-26c59d3e-1714-11e8-90eb-720d5bb3df41.gif)

### Requirments
- Xcode 9+
- Swift 4
- iOS 8+

### How to use
drag `GDTextSlot` to your project and use!

### Sample
- Create it with code
```
swift
let frame = CGRect(x: 0, y: 0, width: 300, height: 60)
let slotView = GDTextSlot(frame: frame)
slotView.delegate = self
view.addSubview(slotView)

// if you want it to be activated at first!. it will be activated on touch.
//slotView.becomeFirstResponder()

// KeyboardType can be set like this. default is .numberPad
slotView.keyboard = .default

// Change number of available slots. default is 4
slotView.numberOfSlots = 6

// Change space between slots. default is 30
slotView.baseWidth = 40
```

- Storyboard
1) Add view to storyboard and set custom class to `GDTextSlot`
2) Change attributes through attribute inspector

and run!

For getting entered text add delegate method

```
swift

func onTextEntered(_ slotView: GDTextSlot, _ finalText: String) {
    print(finalText)
}
```

do not forget to set `GDTextSlotDelegate` to view controller.
