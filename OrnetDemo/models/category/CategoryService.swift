//
//  CategoryService.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//


import Foundation
import Alamofire

public protocol CategoryServiceProtocol {
    func fetchCategorys(completion: @escaping (Result<[Category]>) -> Void)
}

public class CategoryService: Service,CategoryServiceProtocol {

    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }


    public func fetchCategorys(completion: @escaping (Result<[Category]>) -> Void) {
        let urlString = super.baseURL+"category.php"

        AF.request(urlString)
          .validate()
          .responseDecodable(of: [Category].self) { (response) in
            switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(Error.networkError(internal: error)))
                    }
                }

            }

//        AF.request(urlString).responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                let decoder = Decoders.plainDecoder
//                do {
//                    let response = try decoder.decode([Category].self, from: data)
//                    completion(.success(response))
//                } catch {
//                    completion(.failure(Error.serializationError(internal: error)))
//                }
//            case .failure(let error):
//                completion(.failure(Error.networkError(internal: error)))
//            }
//        }
 //   }
}
