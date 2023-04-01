//
//  CurrencyViewController.swift
//  PipeCalculator
//
//  Created by tosy on 21.02.23.
//

import Alamofire
import SwiftyJSON
import UIKit
import Spring
final class CurrencyViewController: UIViewController {
    var currency = Currency()
    
    @IBOutlet weak var pipeLbl: UILabel!
    
    @IBOutlet weak var lengthLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    
    
    @IBOutlet weak var curView: UIView!
    
    @IBOutlet weak var back: UIBarButtonItem!
    
    @IBOutlet weak var pipeParam: UILabel!
    
    @IBOutlet var views: UIView!
    @IBOutlet var usdArrow: UIImageView!
    @IBOutlet var eurArrow: UIImageView!
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
    
    @IBOutlet var priceTextField: SpringTextField!
    
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
        pipeLabel.text = " \(currency.diametr) x \(currency.tolshina) mm"
        lenghtHeightLabel.text = " \(currency.dlina) m"
        weightLabel.text = "\(currency.height) tn"
        usdLabel.text = "1 USD = \(currency.usd) BYN | \(round((Float(currency.usd)! - Float(currency.usdBeforeDay)!) * 10000) / 10000)"
        eurLabel.text = "1 EUR = \(currency.eur) BYN | \(round((Float(currency.eur)! - Float(currency.eurBeforeDay)!) * 10000) / 10000)"
    }
    
    private func segmention() {
        switch currency.segmentos {
        case 0:
            totalPriceLabel.text = "Price \(currency.finishPrice) BYN"
        case 1:
            totalPriceLabel.text = "Price \(round(currency.finishPrice / Float(currency.usd)! * 10000) / 10000) USD"
        case 2:
            totalPriceLabel.text = "Price \(round(currency.finishPrice / Float(currency.eur)! * 10000) / 10000) EUR"
        default:
            print("lol")
        }
    }
    
    private func priceTfAction() {
        guard let price = Float(priceTextField.text!.replacingOccurrences(of: ",", with: ".")) else { priceTextField.text?.removeAll()
            priceTextField.animation = Animations.shake.rawValue
            priceTextField.force = 0.25
            priceTextField.animate()
            totalPriceLabel.text = "Enter price in BYN"
            currency.finishPrice = 0
            return
        }
        let totalPrice = (round((currency.height * price) * 1000) / 1000)
        currency.finishPrice = totalPrice
        segmention()
    }
    
    private func currencyViewSetting() {
        back.title = "back"
        curView.layer.cornerRadius = 20
        views.layer.cornerRadius = 20
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        currMinusEur()
//        totalPriceLabel.font = UIFont(name: "MoonFlower", size: 48)
//        pipeLabel.font = UIFont(name: "MoonFlower", size: 43)
//        lenghtHeightLabel.font = UIFont(name: "MoonFlower", size: 43)
//        usdLabel.font = UIFont(name: "MoonFlower", size: 43)
//        eurLabel.font = UIFont(name: "MoonFlower", size: 43)
//        priceTextField.font = UIFont(name: "MoonFlower", size: 43)
        currMinusUsd()
    }
    
    private func currMinusUsd() {
        let usd = round((Float(currency.usd)! - Float(currency.usdBeforeDay)!) * 10000) / 10000
        if usd == 0 {
            usdArrow.alpha = 0
        }
        if usd > 0 {
            usdArrow.tintColor = .green
        }
        
        if usd < 0 {
            usdArrow.tintColor = .red
            usdArrow.transform = usdArrow.transform.rotated(by: .pi)
        }
    }
    
    private func currMinusEur() {
        let eur = round((Float(currency.eur)! - Float(currency.eurBeforeDay)!) * 10000) / 10000
        if eur == 0 {
            eurArrow.alpha = 0
        }
        if eur > 0 {
            eurArrow.tintColor = .green
        }
        
        if eur < 0 {
            eurArrow.tintColor = .red
            eurArrow.transform = eurArrow.transform.rotated(by: .pi)
        }
    }
}
