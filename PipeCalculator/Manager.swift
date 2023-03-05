//
//  Manager.swift
//  PipeCalculator
//
//  Created by tosy on 30.01.23.
//

import Foundation
import UIKit

let calendar = Calendar.current
var date = Date()
let day = calendar.dateComponents([.day], from: date).day!
let month = calendar.dateComponents([.month], from: date).month!
func string() -> String {
    let url = "http://numbersapi.com/\(month)/\(day)/date?json"
    let calendar = Calendar.current
    let date = Date()
    let day = calendar.dateComponents([.day], from: date).day!
    let month = calendar.dateComponents([.month], from: date).month!
    print(day)
    print(date)
    print(url)
    print(month)
    return url
}

struct Url {
    let url = "https://www.nbrb.by/api/exrates/rates?periodicity=0"
}

struct Currency {
    var diametr: Float = 0
    var tolshina: Float = 0
    var dlina: Float = 0
    var height: Float = 0
    var usd: String = ""
    var eur: String = ""
    var finishPrice: Float = 0
    var segmentos = 0
}
