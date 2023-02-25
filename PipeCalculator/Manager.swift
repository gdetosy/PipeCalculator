//
//  Manager.swift
//  PipeCalculator
//
//  Created by tosy on 30.01.23.
//

import Foundation


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
  return url
}

