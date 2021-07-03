//
//  Product.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import Foundation


public struct Product:Codable,Hashable,Equatable {
    let id:Int
    let name:String
    let image:String
    let price:Int
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static public func == (lhs: Self, rhs: Self) -> Bool{
        return lhs.id == rhs.id
    }
    

}
