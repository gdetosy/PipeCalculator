//
//  CurrencyViewController.swift
//  PipeCalculator
//
//  Created by tosy on 21.02.23.
//

import Alamofire
import SwiftyJSON
import UIKit

class CurrencyViewController: UIViewController {
    var diametr: Float = 0
    var tolshina: Float = 0
    var dlina: Float = 0
    var height: Float = 0
    var usd: String = ""
    var eur: String = ""
    var finishPrice: Float = 0
    var segmentos = 0
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
    
    @IBOutlet var priceTextField: UITextField!
    
    @IBOutlet var segmentConrol: UISegmentedControl!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBOutlet var usdLabel: UILabel!
    
    @IBOutlet var eurLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalPriceLabel.text = "Введите цену в BYN"
        getParametrs()
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {
        if priceTextField.text?.isEmpty == true {
            //            finishPrice = 0
            totalPriceLabel.text = "Введите цену в BYN"
        } else {
            guard let price = Float(priceTextField.text!) else { return }
            let totalPrice = (round((height * price) * 1000) / 1000)
            finishPrice = totalPrice
            segmention()
        }
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentos = 0
            segmention()
        case 1:
            segmentos = 1
            segmention()
        case 2:
            segmentos = 2
            segmention()
        default:
            print("lol")
        }
    }
    
    private func getParametrs() {
        pipeLabel.text = " Труба \(diametr) x \(tolshina) мм Сталь 3пс"
        
        lenghtHeightLabel.text = "Длинна \(dlina)м, вес  \(height)тн"
        
        usdLabel.text = "1 USD = \(usd) руб"
        eurLabel.text = "1 EUR = \(eur) руб"
    }

    func segmention() {
        if segmentos == 0 {
            totalPriceLabel.text = "Цена \(finishPrice) рублей без НДС"
        }
        if segmentos == 1 {
            totalPriceLabel.text = "Цена \(finishPrice * Float(usd)!) USD без НДС"
        }
        if segmentos == 2 {
            totalPriceLabel.text = "Цена \(finishPrice * Float(eur)!) EUR без НДС"
        }
    }
}
