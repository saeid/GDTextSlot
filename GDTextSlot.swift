//
//  GDTextSlot.swift
//  DeepLink
//
//  Created by Saeid Basirnia on 2/21/18.
//  Copyright © 2018 SigmaTelecom. All rights reserved.
//

import UIKit

protocol GDTextSlotDelegate: class{
    func onTextEntered(_ slotView: GDTextSlot, _ finalText: String)
}

@IBDesignable
class GDTextSlot: UIView, UIKeyInput {
    public weak var delegate: GDTextSlotDelegate? = nil
    
    /// Nothing special! our beloved variables :D
    private var currentSlot: Int = 1
    public var keyboard: UIKeyboardType = .numberPad
    
    @IBInspectable
    public var numberOfSlots: Int = 4 {
        didSet{
            clearView()
            generateSlots()
        }
    }
    @IBInspectable
    public var baseWidth: CGFloat = 30.0 {
        didSet{
            clearView()
            generateSlots()
        }
    }
    
    // MARK: - Self properties
    public var hasText: Bool{
        return currentSlot > 1
    }
    
    public override var canBecomeFirstResponder : Bool{
        return true
    }
    
    public var keyboardType: UIKeyboardType {
        get{
            return keyboard
        }
        set {}
    }
    
    /// If slots are field return
    /// Adds digits to slots or if we are done, retrun the code
    func insertText(_ text: String) {
        if currentSlot > numberOfSlots{
            return
        }
        guard let slot = viewWithTag(currentSlot) as? UILabel else{
            return
        }
        slot.text = text
        currentSlot += 1
        
        if currentSlot == numberOfSlots + 1{
            var finishedCode: String = ""
            for s in 1...numberOfSlots{
                guard let slotVal = (viewWithTag(s) as? UILabel)?.text else{
                    continue
                }
                finishedCode += slotVal
            }
            delegate?.onTextEntered(self, finishedCode)
        }
    }
    
    func deleteBackward() {
        if currentSlot <= 1{
            return
        }
        currentSlot -= 1
        
        guard let slot = viewWithTag(currentSlot) as? UILabel else{
            return
        }
        slot.text = "_"
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Calculate X position of slot and make sure
    /// the whole group is always in center of the view
    private func calcX() -> CGFloat{
        return ((frame.width - (baseWidth * CGFloat(numberOfSlots))) / 2) + (CGFloat((currentSlot - 1)) * CGFloat(baseWidth))
    }
    
    private func calcFrame() -> CGRect{
        return CGRect(x: calcX(), y: 0, width: baseWidth, height: frame.height)
    }
    
    /// Initiate a new label for the slot!
    private var label: UILabel{
        let lbl: UILabel = UILabel()
        lbl.frame = calcFrame()
        lbl.text = "_"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textAlignment = .center
        lbl.tag = currentSlot
        
        return lbl
    }

    /// Clear the view when changing values
    private func clearView(){
        for v in subviews{
            v.removeFromSuperview()
        }
    }
    
    public func generateSlots(){
        for index in 1...numberOfSlots{
            currentSlot = index
            addSubview(label)
        }
        currentSlot = 1
    }
    
    
    /// Getting touch to activate the view and call becomeFirstResponder()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else{
            return
        }
        if firstTouch.view == self{
            self.becomeFirstResponder()
        }
    }
}
