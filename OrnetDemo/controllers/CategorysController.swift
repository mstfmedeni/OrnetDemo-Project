//
//  CategorysController.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import UIKit

private let reuseIdentifier = "CategoryCollectionCell"

final class CategorysController: BaseViewController {

    private var categorys:[Category] = []
    var service: CategoryServiceProtocol = CategoryService()

    @IBOutlet weak var collection:UICollectionView!{
        didSet{
            collection.delegate = self
            collection.dataSource = self
            collection.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatas()
    }

    func loadDatas(){
        LoadingView.showActivityIndicator()
        service.fetchCategorys { (result) in
            print(result)
            LoadingView.hideActivityIndicator()
            switch result{
            case .success(let ctgry):
                self.categorys = ctgry
                self.collection.reloadData()
                break
            case .failure(let err):
                self.presentSingleActionAlert( message: err.localizedDescription)
                break
            }
        }
    }

}
extension CategorysController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cll = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CategoryCollectionCell else { return UICollectionViewCell() }
        let rw = categorys[indexPath.row]

        cll.prepafeView(rw.name, rw.image)

        return cll

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return .init(width: collectionView.frame.width*0.95, height: collectionView.frame.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:ProductsTableController = ProductsTableController.initlizeWithStoryBoard()
        vc.category = self.categorys[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
