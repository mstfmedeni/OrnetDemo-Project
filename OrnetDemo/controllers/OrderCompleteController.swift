//
//  OrderCompleteController.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import UIKit

final class OrderCompleteController:  BaseViewController {

    @IBOutlet weak var lblOrderNo:UILabel!

    var orderID:Int = 0
     override func viewDidLoad() {
        super.viewDidLoad()
        self.lblOrderNo.text = "\(orderID)"
        // Do any additional setup after loading the view.
    }
    @IBAction func doneAppend(){
        self.dismiss(animated: true) {
            setRootController(createNavController(CategorysController.initlizeWithStoryBoard()))
        }
    }
    

}
