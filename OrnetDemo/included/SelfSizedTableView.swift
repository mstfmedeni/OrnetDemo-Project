//
//  SelfSizedTableView.swift
//  DogiDogi
//
//  Created by Mustafa MEDENi on 2.03.2020.
//  Copyright © 2020 Mustafa MEDENi. All rights reserved.
//

import Foundation
import UIKit

class SelfSizedTableView: UITableView {
    
    override open var contentSize: CGSize {
        didSet { // basically the contentSize gets changed each time a cell is added
            // --> the intrinsicContentSize gets also changed leading to smooth size update
            if oldValue != contentSize {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
        self.isScrollEnabled = false
    }
    
}


