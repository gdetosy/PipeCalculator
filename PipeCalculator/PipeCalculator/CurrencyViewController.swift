//
//  CurrencyViewController.swift
//  PipeCalculator
//
//  Created by tosy on 21.02.23.
//

import UIKit
import Alamofire
import SwiftyJSON

class CurrencyViewController: UIViewController {
    var diametr: Float = 0
    var tolshina: Float = 0
    var dlina: Float = 0
    var height: Float = 0
//    let url = "https://www.nbrb.by/api/exrates/rates?periodicity=0"
    var usd: String = ""
    var eur: String = ""
    var finishPrice: Float = 0
    
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
   
    @IBOutlet var priceTextField: UITextField!
    
    @IBOutlet var segmentConrol: UISegmentedControl!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBOutlet var usdLabel: UILabel!
    
    @IBOutlet var eurLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getPrice(url: url)
        getParametrs()
       
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {
        guard let price = Float(priceTextField.text!) else { return }
        let totalPrice = (round((height * price) * 1000) / 1000)
        finishPrice = totalPrice
        totalPriceLabel.text = "Цена \(totalPrice) рублей без НДС"
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            guard let price = Float(priceTextField.text!) else { return }
            let totalPrice = (round((height * price) * 1000) / 1000)
            
            totalPriceLabel.text = "Цена \(totalPrice) рублей без НДС"
            print("0")
        case 1:
            totalPriceLabel.text = "Цена \(finishPrice * Float(usd)!) USD без НДС"
            
           
        case 2:
            totalPriceLabel.text = "Цена \(finishPrice * Float(eur)!) EUR без НДС"
        default:
            print("lol")
        }
        
        
        
    }
  
//    func getPrice(url: String) {
//        AF.request(url).responseJSON { [weak self] response in switch response.result {
//        case .success(let value):
//            let json = JSON(value)
//
//            self?.usdLabel.text = "USD: \(json[7, "Cur_OfficialRate"]) "
//            self?.eurLabel.text = "EUR: \(json[9, "Cur_OfficialRate"]) "
//            self?.usd = "\(json[7, "Cur_OfficialRate"])"
//
//        case .failure:
//            print("error")
//        }
//        }
//    }

    private func getParametrs() {
        pipeLabel.text = " Труба \(diametr) x \(tolshina) мм Сталь 3пс"
        
        lenghtHeightLabel.text = "Длинна \(dlina)м, вес  \(height)тн"
       
        usdLabel.text = "1 USD = \(usd) руб"
        eurLabel.text = "1 EUR = \(eur) руб"
    }
    
}
