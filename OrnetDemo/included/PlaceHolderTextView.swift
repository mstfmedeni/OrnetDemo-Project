//
//  PlaceHolderTextView.swift
//  Scarlett
//
//  Created by Mustafa MEDENi on 20.03.2020.
//  Copyright © 2020 Mustafa Medeni. All rights reserved.
//

import Foundation
import UIKit

class PlaceHolderTextView: UITextView {
    var placeholderLabel : UILabel = UILabel()
    
    @IBInspectable var placeHolder:String=""{
        didSet{
            placeholderLabel.text = self.placeHolder
            self.placeholderLabel.text = placeHolder
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
        placeholderLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        placeholderLabel.text = self.placeHolder
        self.placeholderLabel.sizeToFit()

        self.addSubview(placeholderLabel)
      //  placeholderLabel.frame.origin = CGPoint(x: (self.frame.width/2)-placeholderLabel.frame.width/2, y: (self.frame.height/2)-placeholderLabel.frame.height/2)

        let x = self.textContainer.lineFragmentPadding
                  let y = self.textContainerInset.top - 2
                  let width = self.frame.width - (x * 2)
                  let height = placeholderLabel.frame.height

        placeholderLabel.frame = CGRect(x: x, y: y, width: width, height: height)

        placeholderLabel.textColor = UIColor.lightGray.withAlphaComponent(0.5)
        placeholderLabel.isHidden = !(self.text.isEmpty)
        
    }
}
extension PlaceHolderTextView:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !self.text.isEmpty
    }
}
