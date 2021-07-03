//
//  OrderReivewResponse.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import Foundation

public  struct OrderReviewResponse:Codable {
    var order:Order
    var products:[Product:Int]
    var countryN:String
    var cityN:String
    var distN:String


}
public struct OrderServiceResponse:Codable {
    var orderID:Int
}
