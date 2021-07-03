//
//  ProductTableCell.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import UIKit

class ProductTableCell: UITableViewCell {

    @IBOutlet weak var imgProd: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var btnAdd: UIButton!
    
    var addCartAded:((Int)->())?


    var productCount:Int = 0{
        didSet{
            self.stepper.isHidden =  (self.productCount == 0)
            self.lblCount.isHidden =  (self.productCount == 0)
            self.btnAdd.isHidden = !(self.productCount == 0)
            self.lblCount.text = "\(self.productCount) Adet"
            self.addCartAded?(productCount)

         }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addCart(){
        self.productCount = 1
    }
    func prepareView(_ title:String,_ price:Int,_ action:((Int)->())?=nil){
        self.addCartAded = action
        self.lblTitle.text = title
        self.lblPrice.text = "\(price) TL"
     }
    @IBAction func stepperChanged(_ sender: UIStepper) {
        self.productCount = Int(sender.value)
    }
    func loadImage(_ img:String){

        imgProd.moa.onSuccess = { image in
          return image
        }

        imgProd.moa.url = img

    }
    override func prepareForReuse() {
        self.imgProd.image = nil
    }

}
