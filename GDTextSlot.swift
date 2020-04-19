//
//  GDTextSlot.swift
//
//
//  Created by Saeid Basirnia on 2/21/18.
//  Copyright © 2018 Saeid Basirnia. All rights reserved.
//

import UIKit

public protocol GDTextSlotDelegate: class {
	func onTextEntered(_ finalText: String)
}

@IBDesignable
final public class GDTextSlot: UIView, UIKeyInput {
	public weak var delegate: GDTextSlotDelegate? = nil
	
	private var lock: Bool = false
	private var currentSlot: Int = 1
	
	// MARK: - Public variables
	public var keyboard: UIKeyboardType = .numberPad
	@IBInspectable
	public var numberOfSlots: Int = 4 {
		didSet {
			clearAndGenerate()
		}
	}
	@IBInspectable
	public var baseWidth: CGFloat = 50.0 {
		didSet {
			clearAndGenerate()
		}
	}
	@IBInspectable
	public var placeholder: String = "___" {
		didSet {
			clearAndGenerate()
		}
	}
	public var textFont: UIFont = UIFont.boldSystemFont(ofSize: 25) {
		didSet {
			clearAndGenerate()
		}
	}
	
	// MARK: - Properties
	public var hasText: Bool {
		return currentSlot > 1
	}
	
	public override var canBecomeFirstResponder : Bool {
		return true
	}
	
	public var keyboardType: UIKeyboardType {
		get {
			return keyboard
		}
		set {}
	}
	
	// MARK: - Init
	public override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	public override func layoutSubviews() {
		if hasText { return }
		clearAndGenerate()
	}
	
	// MARK: - Insert/Delete text
	public func insertText(_ text: String) {
		if currentSlot > numberOfSlots { return }
		if lock { return }
		guard let slot = viewWithTag(currentSlot) as? UILabel else { return }
		
		currentSlot += 1
		lock = true
		
		UIView.animate(withDuration: 0.05, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
			slot.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
			slot.alpha = 0
		}) { (_) in
			UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveEaseInOut, animations: {
				slot.alpha = 1
				slot.transform = .identity
				slot.text = text
				
			}) { (_) in
				self.lock = false
				self.updateTextStatus()
			}
		}
	}
	
	public func deleteBackward() {
		if currentSlot <= 1 { return }
		currentSlot -= 1
		guard let slot = viewWithTag(currentSlot) as? UILabel else { return }
		
		UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
			slot.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
			slot.alpha = 0
		}) { (_) in
			UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
				slot.alpha = 1
				slot.transform = .identity
				slot.text = self.placeholder
				
			}, completion: nil)
		}
	}
	
	// MARK: - Slots generator
	public func generateSlots() {
		for index in 1...numberOfSlots {
			currentSlot = index
			addSubview(label)
		}
		currentSlot = 1
	}
	
	private func clearView() {
		for v in subviews{
			v.removeFromSuperview()
		}
	}
	
	private func clearAndGenerate() {
		clearView()
		generateSlots()
	}
	
	/// Calculate X position of slot
	private var xPosition: CGFloat {
		return ((frame.width - (baseWidth * CGFloat(numberOfSlots))) / 2) + (CGFloat((currentSlot - 1)) * CGFloat(baseWidth))
	}
	
	private var frameRect: CGRect {
		return CGRect(x: xPosition, y: 0, width: baseWidth, height: frame.height)
	}
	
	private var currentText: String {
		var code: String = ""
		for s in 1...numberOfSlots {
			guard let slotValue = (viewWithTag(s) as? UILabel)?.text else {
				continue
			}
			code += slotValue
		}
		return code
	}
	
	private var label: UILabel {
		let lbl: UILabel = UILabel()
		lbl.frame = frameRect
		lbl.text = placeholder
		lbl.textColor = UIColor.black
		lbl.font = textFont
		lbl.textAlignment = .center
		lbl.tag = currentSlot
		
		return lbl
	}
	
	private func updateTextStatus() {
		if currentSlot == numberOfSlots + 1 {
			delegate?.onTextEntered(currentText)
		}
	}
	
	private func updateTextStatus(_ text: String) {
		let textArray = Array(text)
		for s in 1...numberOfSlots {
			guard let slotValue = (viewWithTag(s) as? UILabel) else {
				continue
			}
			slotValue.text = String(textArray[s-1])
		}
		currentSlot = numberOfSlots + 1
		delegate?.onTextEntered(text)
	}
	
	/// Getting touch to activate the view and call becomeFirstResponder()
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let firstTouch = touches.first else {
			return
		}
		if firstTouch.view == self {
			self.becomeFirstResponder()
		}
	}
}
