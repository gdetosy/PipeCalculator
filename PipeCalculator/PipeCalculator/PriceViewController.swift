//
//  PriceViewController.swift
//  PipeCalculator
//
//  Created by tosy on 24.02.23.
//

import UIKit

class PriceViewController: UIViewController {
    var currency = Currency()
    
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
   
    @IBOutlet var priceTextField: UITextField!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getParametrs()
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {
        if priceTextField.text?.isEmpty == true {
            currency.finishPrice = 0
        } else {
            guard let price = Float(priceTextField.text!) else { return }
            let totalPrice = (round((currency.height * price) * 1000) / 1000)
            currency.finishPrice = totalPrice
            totalPriceLabel.text = "Цена \(totalPrice) рублей без НДС"
        }
    }

    private func getParametrs() {
        pipeLabel.text = " Труба \(currency.diametr) x \(currency.tolshina) мм Сталь 3пс"
        
        lenghtHeightLabel.text = "Длинна \(currency.dlina)м, вес  \(currency.height)тн"
    }
}
