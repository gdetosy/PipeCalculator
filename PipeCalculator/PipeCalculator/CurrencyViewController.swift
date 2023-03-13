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
        self.hideKeyboardWhenTappedAround() 
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
        pipeLabel.text = " Pipe \(currency.diametr) x \(currency.tolshina) mm steel 3ps"
        
        lenghtHeightLabel.text = "Thickness \(currency.dlina)m, weight  \(currency.height)tn"
        
        usdLabel.text = "1 USD = \(currency.usd) BYN"
        eurLabel.text = "1 EUR = \(currency.eur) BYN"
    }

    private func segmention() {
        switch currency.segmentos {
        case 0:
            totalPriceLabel.text = "Price \(currency.finishPrice) BYN"
        case 1:
            totalPriceLabel.text = "Price \(currency.finishPrice * Float(currency.usd)!) USD"
        case 2:
            totalPriceLabel.text = "Price \(currency.finishPrice * Float(currency.eur)!) EUR"
        default:
            print("lol")
        }
    }

    private func priceTfAction() {
        guard let price = Float(priceTextField.text!) else { priceTextField.text?.removeAll()
            totalPriceLabel.text = "Enter price in BYN"
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
        totalPriceLabel.font = UIFont(name: "Minecrafter", size: 25)
        pipeLabel.font = UIFont(name: "Minecrafter", size: 25)
        lenghtHeightLabel.font = UIFont(name: "Minecrafter", size: 25)
        usdLabel.font = UIFont(name: "Minecrafter", size: 25)
        eurLabel.font = UIFont(name: "Minecrafter", size: 25)
        priceTextField.font = UIFont(name: "Minecrafter", size: 25)
    }
    
    
    
}



