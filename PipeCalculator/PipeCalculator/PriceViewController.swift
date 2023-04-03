//
//  PriceViewController.swift
//  PipeCalculator
//
//  Created by tosy on 24.02.23.
//

import UIKit

class PriceViewController: UIViewController {
    var currency = Currency()
    
    @IBOutlet weak var views: UIView!
    
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
   
    @IBOutlet var priceTextField: UITextField!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      priceSettings()
        getParametrs()
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {
       priceTF()
    }

    private func getParametrs() {
        pipeLabel.text = " \(currency.diametr) x \(currency.tolshina) mm"
        weightLbl.text = " \(currency.height) tn"
        lenghtHeightLabel.text = " \(currency.dlina) m"
    }

    private func priceTF() {
        guard let price = Float(priceTextField.text!.replacingOccurrences(of: ",", with: ".")) else { priceTextField.text?.removeAll()
            
            currency.finishPrice = 0
            return
        }
        let totalPrice = (round((currency.height * price) * 1000) / 1000)
        currency.finishPrice = totalPrice
        totalPriceLabel.text = "Price \(totalPrice) BYN"
    }
    func priceSettings() {
        views.layer.cornerRadius = 20
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "off")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
}
