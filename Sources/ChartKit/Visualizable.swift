//
//  Visualizable.swift
//  
//
//  Created by Atulya Weise on 1/11/22.
//

import Foundation

/**
 Example Implementation:
 ```
 struct Purchase {
    var date: Date
    var amount: Int
    var name: String
 }
 
 extension Purchase: LineVisualizable {
    func numericX() -> Double {
        return date.timeIntervalSince1970
    }
     func numericY() -> Double {
         return amount
     }
     func label() -> String {
         "Test"
     }
 }
 ```
 */
public protocol BarVisualizable: Identifiable, Equatable {
    func numericX() -> Double
    func numericY() -> Double
    func label() -> String
}

public protocol BarInteractive: BarVisualizable {
    func setX(to: Double)
    func setY(to: Double)
}


public enum Scale {
    case real
    case pretty
}
