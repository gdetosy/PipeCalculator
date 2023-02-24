//
//  PriceViewController.swift
//  PipeCalculator
//
//  Created by tosy on 24.02.23.
//

import UIKit

class PriceViewController: UIViewController {
    var diametr: Float = 0
    var tolshina: Float = 0
    var dlina: Float = 0
    var height: Float = 0
    var finishPrice: Float = 0
    
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
            finishPrice = 0
        } else {
            guard let price = Float(priceTextField.text!) else { return }
            let totalPrice = (round((height * price) * 1000) / 1000)
            finishPrice = totalPrice
            totalPriceLabel.text = "Цена \(totalPrice) рублей без НДС"
        }
    }

    private func getParametrs() {
        pipeLabel.text = " Труба \(diametr) x \(tolshina) мм Сталь 3пс"
        
        lenghtHeightLabel.text = "Длинна \(dlina)м, вес  \(height)тн"
    }
}
