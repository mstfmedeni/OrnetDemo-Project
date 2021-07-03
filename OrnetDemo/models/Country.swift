//
//  Country.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import Foundation

struct Country:Codable {
    let id:Int
    let name:String
    let cities:[city]

    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case cities = "states"

    }


    static public func gets()->[Country]{
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                let jsonResult = try JSONDecoder().decode([Country].self, from: data)

                return jsonResult

              } catch {
                   return []
              }
        }
        return []
    }
}
struct city:Codable {
    let id:Int
    let name:String
    let distincs:[dist]

    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case distincs = "cities"

    }


    
}

struct dist:Codable {
    let id:Int
    let name:String
 }


