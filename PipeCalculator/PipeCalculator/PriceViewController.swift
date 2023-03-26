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
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {
       priceTF()
    }

    private func getParametrs() {
        pipeLabel.text = " Труба \(currency.diametr) x \(currency.tolshina) мм Сталь 3пс"
        
        lenghtHeightLabel.text = "Длинна \(currency.dlina)м, вес  \(currency.height)тн"
    }

    private func priceTF() {
        guard let price = Float(priceTextField.text!.replacingOccurrences(of: ",", with: ".")) else { priceTextField.text?.removeAll()
            currency.finishPrice = 0
            return
        }
        let totalPrice = (round((currency.height * price) * 1000) / 1000)
        currency.finishPrice = totalPrice
        totalPriceLabel.text = "Цена \(totalPrice) рублей без НДС"
    }
}
