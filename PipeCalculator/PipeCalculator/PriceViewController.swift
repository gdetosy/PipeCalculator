//
//  PriceViewController.swift
//  PipeCalculator
//
//  Created by tosy on 24.02.23.
//

import UIKit
import Spring

class PriceViewController: UIViewController {
    var currency = Currency()
    
    @IBOutlet var views: UIView!
    
    @IBOutlet var weightLbl: UILabel!
    
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
   
    @IBOutlet var priceTextField: SpringTextField!
    
    @IBOutlet var totalPriceLabel: SpringLabel!
    
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
        anime()
        priceTextField.animation = Animations.shake.rawValue
        priceTextField.force = 0.25
        priceTextField.animate()
        guard let price = Float(priceTextField.text!.replacingOccurrences(of: ",", with: ".")) else {
            totalPriceLabel.text = "Enter price in BYN"
            priceTextField.text?.removeAll()
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
    private func anime() {
        totalPriceLabel.animation = Animations.pop.rawValue
        totalPriceLabel.force = 0.25
        totalPriceLabel.animate()
    }
    
}

