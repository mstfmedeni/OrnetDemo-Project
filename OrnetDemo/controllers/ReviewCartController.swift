//
//  ReviewCartController.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import UIKit

final class ReviewCartController: BaseViewController {

    let service:OrderService = OrderService()
    var reviewResponse:OrderReviewResponse!

    @IBOutlet weak var productsStack:UIStackView!
    @IBOutlet weak var InformationStack:UIStackView!

    @IBOutlet weak var lblSum:UILabel!
    @IBOutlet weak var lblDiscount:UILabel!
    @IBOutlet weak var lblTotal:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }
    func prepareView(){
        for (prd,cnt) in reviewResponse.products{
            self.productsStack.addArrangedSubview(prepareProductLabel(prd, cnt))
        }
        let totalCount = reviewResponse.products.keys.map({$0.price*reviewResponse.products[$0]! }).reduce(0,+)
        lblSum.text = "\(totalCount) TL"
        lblDiscount.text = "\(self.reviewResponse.order.discount) TL"
        lblTotal.text = "\(totalCount-self.reviewResponse.order.discount) TL"

        prepareInformationLabel("Ad Soyad", self.reviewResponse.order.name+" "+self.reviewResponse.order.surname)
        prepareInformationLabel("Telefon Numarası", self.reviewResponse.order.phone)
        prepareInformationLabel("Email", self.reviewResponse.order.email)
        let address:String = "\(self.reviewResponse.order.adress) \n \(self.reviewResponse.countryN) / \(self.reviewResponse.cityN) /\(self.reviewResponse.distN)"

        prepareInformationLabel("Adres", address)

        

    }

    @IBAction func completeAppend(){
        service.postOrder(orders: self.reviewResponse) { (result) in
            switch result{
            case .success(let result):

                CartProduct.removeAll()

                let vc:OrderCompleteController = OrderCompleteController.initlizeWithStoryBoard()
                vc.orderID = result.orderID
                let vcc = createNavController(vc)
                self.present(vcc, animated: true, completion: nil)
                break
            case .failure(let err):
                self.presentSingleActionAlert( message: err.localizedDescription)
                break
            }
        }

    }


    func prepareInformationLabel(_ title:String,_ text:String){
        let first = NSMutableAttributedString(string: "\(title)\n",attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14, weight: .semibold)])
        let second = NSAttributedString(string: text)


        let lbl = UILabel()
        lbl.numberOfLines = 0

        first.append(second)

        lbl.attributedText = first

        self.InformationStack.addArrangedSubview(lbl)
    }

    func prepareProductLabel(_ prd:Product,_ cnt:Int)->UILabel{

        let first = NSMutableAttributedString(string: "\(prd.name)\n",attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14, weight: .semibold)])
        let second = NSAttributedString(string: "\(prd.price) * \(cnt)")


        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.right
            let totoal = NSAttributedString(string: "\t=\t\(prd.price*cnt)",attributes: [.paragraphStyle: style])

        first.append(second)
        first.append(totoal)

        let lbl = UILabel()
        lbl.numberOfLines = 2
             lbl.attributedText = first

        return lbl
    }
}
