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

protocol alert {
    func alert()
    func alert1()
    
}

extension MainViewController: alert {
    func alert() {
        let alert = UIAlertController(title: "Формула расчета", message: "Трубный калькулятор  производит расчет веса круглой электросварной трубы по формуле:                                      Масса трубы = ((диаметр трубы  - толщина стенки) х толщина стенки х 0.02466 х метраж) / 1000",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func alert1() {
        let alert = UIAlertController(title: "Формула расчета", message: "Трубный калькулятор  производит расчет веса круглой электросварной трубы по формуле:                                     Длинна трубы = масса * 1000 / ((диаметр трубы - толщина стенки) * 0.0246 * толщина стенки)",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}

 
