//
//  CartController.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import UIKit

private let reuseIdentifier = "ProductTableCell"

class CartController: BaseViewController {

    private var selectedProducts:[Product:Int] = [:]
    private var products:[Product] = []
    @IBOutlet weak var txtDiscount:UITextField!
    @IBOutlet weak var lblSum:UILabel!
    @IBOutlet weak var lblDiscount:UILabel!
    @IBOutlet weak var lblTotal:UILabel!

    private var orderDetail:Order = Order()

    @IBOutlet weak var tableView:UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            self.tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedProducts = CartProduct.getCartProducts()
        self.products = selectedProducts.keys.map{ $0 }
        self.reloadViews()
        // Do any additional setup after loading the view.
    }
    @IBAction func cleanAppend(){
        self.addAlertAction(title: "Sepet Temizleme", message: "Sepeti Temizlemek istediğine eminmisiniz", cancelTitle: "Vazgeç", defaultTitle: "Sil") { (alrt) in
            CartProduct.removeAll()
            self.selectedProducts = [:]
            self.products = []
            self.reloadViews()
        }
    }
    func reloadViews(){
        self.tableView.reloadData()
        var totalCount = products.map({$0.price*selectedProducts[$0]! }).reduce(0,+)
        lblSum.text = "\(totalCount) TL"
        lblDiscount.text = "\(self.orderDetail.discount) TL"
        lblTotal.text = "\(totalCount-self.orderDetail.discount) TL"
    }
    @IBAction func discountAppend(){
        if let ll = txtDiscount.text, let dsc = Int(ll){
            self.orderDetail.discount = dsc
            self.reloadViews()
            self.view.endEditing(true)
        }else{
            self.presentSingleActionAlert( message: "Lütfen kupon Miktarını Giriniz")
        }
    }
    @IBAction func nextAppend(){
        let vc:ShopingController = ShopingController.initlizeWithStoryBoard()
        vc.orderDetail = self.orderDetail
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
extension CartController:UITableViewDataSource,UITableViewDelegate{



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.products.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ProductTableCell{
            let prod = self.products[indexPath.row]
            cell.loadImage(self.products[indexPath.row].image)

            cell.prepareView(prod.name, prod.price) { [unowned self] (selectedCount) in
                self.selectedProducts[prod] = selectedCount
                if selectedCount == 0{
                    self.selectedProducts.removeValue(forKey: prod)
                }

                CartProduct.saveCartProducts(prods: self.selectedProducts)

            }
            if let cnt = self.selectedProducts[prod]{
                cell.productCount = cnt
            }
            return cell

        }


        return UITableViewCell()

    }


}
