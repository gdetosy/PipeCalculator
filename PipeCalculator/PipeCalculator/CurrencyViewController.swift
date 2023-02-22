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
    let url = "https://www.nbrb.by/api/exrates/rates?periodicity=0"
   
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
   
    @IBOutlet var priceTextField: UITextField!
    
    @IBOutlet var segmentConrol: UISegmentedControl!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBOutlet var usdLabel: UILabel!
    
    @IBOutlet var eurLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPrice(url: url)
        getParametrs()
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {}
    
    @IBAction func segmentControl(_ sender: Any) {}
  
    func getPrice(url: String) {
        AF.request(url).responseJSON { [weak self] response in switch response.result {
        case .success(let value):
            let json = JSON(value)
           
            self?.usdLabel.text = "USD: \(json[7, "Cur_OfficialRate"]) "
            self?.eurLabel.text = "EUR: \(json[9, "Cur_OfficialRate"]) "
            
        case .failure:
            print("error")
        }
        }
    }

   private func getParametrs() {
        pipeLabel.text = " Труба \(diametr) x \(tolshina) мм Сталь 3пс"
        
        lenghtHeightLabel.text = "Длинна \(dlina)м, вес  \(height)тн"
    }
    
}
