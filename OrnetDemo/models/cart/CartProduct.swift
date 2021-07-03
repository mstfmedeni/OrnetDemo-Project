//
//  CartProduct.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import Foundation

public enum CartProduct {

    public static func saveCartProducts(prods:[Product:Int]) {

        let data = try! JSONEncoder().encode(prods)
         UserDefaults.standard.set(data, forKey: "cartProducts")
        UserDefaults.standard.synchronize()
    }
    public static  func getCartProducts()->[Product:Int]{
        guard let decoded  = UserDefaults.standard.data(forKey: "cartProducts") else { return [:] }
        if let decodedTeams = try? JSONDecoder().decode([Product:Int].self, from: decoded) {
            return decodedTeams
        }
        return [:]

    }
    public static func removeAll(){
        UserDefaults.standard.removeObject(forKey: "cartProducts")
        UserDefaults.standard.synchronize()
    }

}


