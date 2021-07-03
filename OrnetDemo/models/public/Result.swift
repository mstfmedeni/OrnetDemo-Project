//
//  Result.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
