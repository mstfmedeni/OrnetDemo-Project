//
//  ProductService.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import Foundation
import Alamofire

public protocol ProductServiceProtocol {
    func fetchProducts(withCategory cid:Int,completion: @escaping (Result<[Product]>) -> Void)
}

public class ProductService: Service,ProductServiceProtocol {


    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }

    public func fetchProducts(withCategory cid:Int,completion: @escaping (Result<[Product]>) -> Void) {
        let urlString = super.baseURL+"products.php?cid=\(cid)"
        LoadingView.showActivityIndicator()

        AF.request(urlString)
          .validate()
          .responseDecodable(of: [Product].self) { (response) in
            LoadingView.hideActivityIndicator()

            switch response.result {
            
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(Error.networkError(internal: error)))
                    }
                }
            }
}
