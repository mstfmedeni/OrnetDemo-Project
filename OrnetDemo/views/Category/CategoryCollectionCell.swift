//
//  CategoryCollectionCell.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import UIKit
import moa
class CategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        self.img.image = nil
    }
    func prepafeView(_ title:String, _ img:String){
        self.lblTitle.text = title
        self.img.moa.url = img
     }

}
