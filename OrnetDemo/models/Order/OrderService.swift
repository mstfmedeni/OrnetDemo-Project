//
//  OrderService.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import Foundation
import Alamofire

public class OrderService: Service {

    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }


    public func postOrder(orders:OrderReviewResponse,completion: @escaping (Result<OrderServiceResponse>) -> Void) {
        let urlString = super.baseURL+"order.php"

        AF.request(urlString, method: .post, parameters: orders, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: OrderServiceResponse.self

        ) { (response) in
                
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }

    }
}
