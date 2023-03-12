//
//  CurrencyViewController.swift
//  PipeCalculator
//
//  Created by tosy on 21.02.23.
//

import Alamofire
import SwiftyJSON
import UIKit

final class CurrencyViewController: UIViewController {
    var currency = Currency()
    
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
    
    @IBOutlet var priceTextField: UITextField!
    
    @IBOutlet var segmentConrol: UISegmentedControl!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBOutlet var usdLabel: UILabel!
    
    @IBOutlet var eurLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getParametrs()
        currencyViewSetting()
    }
    
    @IBAction private func priceTextField(_ sender: UITextField) {
        priceTfAction()
    }
    
    @IBAction private func segmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currency.segmentos = 0
            segmention()
        case 1:
            currency.segmentos = 1
            segmention()
        case 2:
            currency.segmentos = 2
            segmention()
        default:
            print("lol")
        }
    }
    
    private func getParametrs() {
        pipeLabel.text = " Труба \(currency.diametr) x \(currency.tolshina) мм Сталь 3пс"
        
        lenghtHeightLabel.text = "Длинна \(currency.dlina)м, вес  \(currency.height)тн"
        
        usdLabel.text = "1 USD = \(currency.usd) руб"
        eurLabel.text = "1 EUR = \(currency.eur) руб"
    }

    private func segmention() {
        switch currency.segmentos {
        case 0:
            totalPriceLabel.text = "Цена \(currency.finishPrice) рублей без НДС"
        case 1:
            totalPriceLabel.text = "Цена \(currency.finishPrice * Float(currency.usd)!) USD без НДС"
        case 2:
            totalPriceLabel.text = "Цена \(currency.finishPrice * Float(currency.eur)!) EUR без НДС"
        default:
            print("lol")
        }
    }

    private func priceTfAction() {
        guard let price = Float(priceTextField.text!) else { priceTextField.text?.removeAll()
            totalPriceLabel.text = "Введите цену в BYN"
            currency.finishPrice = 0
            return
        }
        let totalPrice = (round((currency.height * price) * 1000) / 1000)
        currency.finishPrice = totalPrice
        segmention()
    }
    private func currencyViewSetting() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    
}



