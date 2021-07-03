//
//  Order.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import Foundation

//Email
//Şifre
//Ad
//Soyad
//Adres
//Ülke
//Şehir
//İlçe
//Posta kodu
//Telefon numarası

public struct Order:Codable {
    var email:String  = ""
    var pass:String  = ""
    var name:String  = ""
    var surname:String  = ""
    var adress:String  = ""
    var country:Int = 0
    var city:Int = 0
    var dist:Int = 0
    var postalCode:String  = ""
    var phone:String  = ""
    var discount:Int = 0

    
}
