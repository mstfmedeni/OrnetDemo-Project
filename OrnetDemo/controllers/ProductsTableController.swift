//
//  ProductsTableController.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import UIKit

private let reuseIdentifier = "ProductTableCell"

final class ProductsTableController: BaseTableViewController {

    private var products:[Product] = []
    var service: ProductServiceProtocol = ProductService()
    private var selectedProducts:[Product:Int] = [:]

    public var category:Category!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        loadDatas()

        self.title = category.name
    }

    override func viewWillAppear(_ animated: Bool) {
        self.selectedProducts = CartProduct.getCartProducts()
        self.tableView.reloadData()
    }

    func loadDatas(){

        service.fetchProducts(withCategory: category.id)  { (result) in
            print(result)
            switch result{
            case .success(let ctgry):
                self.products = ctgry
                self.tableView.reloadData()
                break
            case .failure(let err):
                self.presentSingleActionAlert( message: err.localizedDescription)
                break
            }
        }
    }


}
extension ProductsTableController{

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.products.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
