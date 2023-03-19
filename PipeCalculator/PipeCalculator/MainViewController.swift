//
//  MainViewController.swift
//  PipeCalculator
//
//  Created by tosy on 28.01.23.
//

import Alamofire
import SwiftyJSON
import UIKit

final class MainViewController: UIViewController, UITextFieldDelegate {
    var array: [String] = []
    var arrayBefore: [String] = []
    let url = Url()
   
    var currency = Currency()
    
    @IBOutlet weak var okThick: UIImageView!
    
    @IBOutlet weak var okLenght: UIImageView!
    
    
    @IBOutlet var ok: UIImageView!
    @IBOutlet var but: UIButton!
    
    @IBOutlet var diametrLbl: UILabel!
    
    @IBOutlet var thicknessLbl: UILabel!
    
    @IBOutlet var heightLabel: UILabel!
   
    @IBOutlet var dlinaLabel: UILabel!
    
    @IBOutlet var diametrTextField: UITextField!
    
    @IBOutlet var tolshinaTextField: UITextField!
    
    @IBOutlet var dlinaTextField: UITextField!
    
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var heightMetr: UILabel!
    
    @IBAction private func diametr(_ sender: UITextField) {
        diametr()
    }
    
    @IBAction private func tolshina(_ sender: UITextField) {
        tolshina()
    }
    
    @IBAction private func dlina(_ sender: UITextField) {
        dlina()
    }
    
    @IBAction private func height(_ sender: UITextField) {
        height()
    }
    
    @IBAction private func raschet(_ sender: UIButton) {
        raschet()
    }
    
    @IBAction private func about(_ sender: Any) {
        about()
    }
    
    @IBAction private func segmentControll(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentCaseOne()
            
        case 1:
            segmentCaseTwo()
        default: print("lol")
        }
    }

    @IBOutlet var mainView: UIView!
    
    @IBOutlet var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPrice(url: url.url)
        getPriceBefore(url: url.urlBeforeDay)
        self.hideKeyboardWhenTappedAround()
        viewSettings()
    }
   
    // MARK: - formula rascheta massa
    
    private func massa() {
        guard let diametr = Float(diametrTextField.text!),
              let stenka = Float(tolshinaTextField.text!),
              let metraj = Float(dlinaTextField.text!)
        else { return }
        let massa1 = ((diametr - stenka) * stenka * 0.02466 * metraj) / 1000
        let heightMetrs = ((diametr - stenka) * stenka * 0.02466 * 1) / 1000
        let kg = (diametr - stenka) * stenka * 0.02466
        heightMetr.text = "1 m weight = \(round(heightMetrs * 100000) / 100000) t = \(kg) kg."
        heightTextField.text = "\(round(massa1 * 100000) / 100000)"
    }
    
    private func lenght() {
        guard let diametr = Float(diametrTextField.text!),
              let stenka = Float(tolshinaTextField.text!),
              let massa = Float(dlinaTextField.text!)
        else { return }
        let metraj1 = massa * 1000 / ((diametr - stenka) * 0.0246 * stenka)
        let heightMetrs = ((diametr - stenka) * stenka * 0.02466 * 1) / 1000
        let kg = (diametr - stenka) * stenka * 0.02466
        heightTextField.text = "\(round(metraj1 * 100000) / 100000)"
        heightMetr.text = "1 m weight = \(round(heightMetrs * 100000) / 100000) t = \(kg) kg."
    }

    //  MARK: - Zapros kursov valut

    private func getPrice(url: String) {
        AF.request(url).responseJSON { [weak self] response in switch response.result {
        case .success(let value):
            let json = JSON(value)
            self?.currency.usd = "\(json[7, "Cur_OfficialRate"])"
            self?.currency.eur = "\(json[9, "Cur_OfficialRate"])"
            self?.array.append("\(json[7, "Cur_OfficialRate"])")
            self?.array.append("\(json[9, "Cur_OfficialRate"])")
            print(self!.array)
        case .failure:
            print("error")
        }
        }
    }
    private func getPriceBefore(url: String) {
        AF.request(url).responseJSON { [weak self] response in switch response.result {
        case .success(let value):
            let json = JSON(value)
            self?.currency.usdBeforeDay = "\(json[7, "Cur_OfficialRate"])"
            self?.currency.eurBeforeDay = "\(json[9, "Cur_OfficialRate"])"
            self?.arrayBefore.append("\(json[7, "Cur_OfficialRate"])")
            self?.arrayBefore.append("\(json[9, "Cur_OfficialRate"])")
            print(self!.arrayBefore)
        case .failure:
            print("error")
        }
        }
    }
    
    
    
    
    
    
    
    
//    MARK: - func for IBActions
   
    private func diametr() {
        guard let diametr = Float(diametrTextField.text!),
              Float(diametrTextField.text!) ?? 0 >= 0
        else { diametrTextField.text?.removeAll(); heightMetr.text = "1 m weight ="
            ok.alpha = 0
            return
        }
        ok.alpha = 1
        if dlinaLabel.text == "Lenght, m" {
           
            massa()
        } else
        { lenght() }
       
    }
    
    private func tolshina() {
        guard let tolshina = Float(tolshinaTextField.text!), Float(tolshinaTextField.text!) ?? 0 < Float(diametrTextField.text!) ?? 0
                
        else {
            okThick.alpha = 0
            tolshinaTextField.text?.removeAll()
            but.isEnabled = false
            heightTextField.text?.removeAll()
            heightMetr.text = "1 m weight ="
            return
        }
        okThick.alpha = 1
        if dlinaLabel.text == "Lenght, m" {
            massa()
            
        } else
        { lenght() }
    }
   
    private func dlina() {
        guard let dlina = Float(dlinaTextField.text!) else { dlinaTextField.text?.removeAll()
            heightTextField.text?.removeAll()
            okLenght.alpha  = 0
            return
        }
        okLenght.alpha = 1
        if dlinaLabel.text == "Lenght, m" {
            massa()
        } else
        { lenght() }
        
        print(dlina)
    }
    
    private func height() {
        if
            diametrTextField.text!.isEmpty || tolshinaTextField.text!.isEmpty || dlinaTextField.text!.isEmpty
        {
            but.isEnabled = false
        } else {
            but.isEnabled = true
        }
        guard Float(heightTextField.text!) != nil else { heightTextField.text?.removeAll()
            but.isEnabled = false
            return
        }
    }
    
    private func about() {
        if dlinaLabel.text == "Lenght, m" { alert() }
        else { alert1() }
    }
    
    private func raschet() {
        if array.count == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editScreen = storyboard.instantiateViewController(withIdentifier:
                "CurrencyViewController") as! CurrencyViewController
            editScreen.currency.diametr = Float(diametrTextField.text!)!
            editScreen.currency.tolshina = Float(tolshinaTextField.text!)!
            editScreen.currency.dlina = Float(dlinaTextField.text!)!
            editScreen.currency.height = Float(heightTextField.text!)!
            editScreen.currency.usd = currency.usd
            editScreen.currency.eur = currency.eur
            editScreen.currency.eurBeforeDay = currency.eurBeforeDay
            editScreen.currency.usdBeforeDay = currency.usdBeforeDay
            self.navigationController?.pushViewController(editScreen, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editScreen = storyboard.instantiateViewController(withIdentifier:
                "PriceViewController") as! PriceViewController
            editScreen.currency.diametr = Float(diametrTextField.text!)!
            editScreen.currency.tolshina = Float(tolshinaTextField.text!)!
            editScreen.currency.dlina = Float(dlinaTextField.text!)!
            editScreen.currency.height = Float(heightTextField.text!)!
            self.navigationController?.pushViewController(editScreen, animated: true)
        }
    }
    
    private func segmentCaseOne() {
        dlinaLabel.text = "Lenght, m"
        heightLabel.text = "Weight, t"
        diametrTextField.text?.removeAll()
        tolshinaTextField.text?.removeAll()
        dlinaTextField.text?.removeAll()
        heightTextField.text?.removeAll()
        heightMetr.text = "1 m weight ="
        height()
        ok.alpha = 0
        okThick.alpha = 0
        okLenght.alpha = 0
    }

    private func segmentCaseTwo() {
        ok.alpha = 0
        okThick.alpha = 0
        okLenght.alpha = 0
        dlinaLabel.text = "Weight, t"
        heightLabel.text = "Lenght, m"
        diametrTextField.text?.removeAll()
        tolshinaTextField.text?.removeAll()
        dlinaTextField.text?.removeAll()
        heightTextField.text?.removeAll()
        heightMetr.text = "1 m weight ="
        height()
    }

    private func viewSettings() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backgroundw")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        diametrTextField.font = UIFont(name: "MoonFlower", size: 30)
        diametrLbl.font = UIFont(name: "MoonFlower", size: 50)
        thicknessLbl.font = UIFont(name: "MoonFlower", size: 50)
        dlinaLabel.font = UIFont(name: "MoonFlower", size: 50)
        heightLabel.font = UIFont(name: "MoonFlower", size: 50)
        heightMetr.font = UIFont(name: "MoonFlower", size: 30)
        dlinaTextField.font = UIFont(name: "MoonFlower", size: 30)
        heightTextField.font = UIFont(name: "MoonFlower", size: 30)
        tolshinaTextField.font = UIFont(name: "MoonFlower", size: 30)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "MoonFlower", size: 30) as Any]
        let segment = [NSAttributedString.Key.font: UIFont(name: "MoonFlower", size: 25)!]
        UISegmentedControl.appearance().setTitleTextAttributes(segment, for: UIControl.State.normal)
        but.tintColor = UIColor.black
        but.backgroundColor = UIColor.white
        let attributedText = NSAttributedString(string: "Calculate the price", attributes: [NSAttributedString.Key.font: UIFont(name: "MoonFlower", size: 20)!])
       but.setAttributedTitle(attributedText, for: .normal)
        
        
        but.titleLabel?.font =  UIFont(name: "Minecrafter", size: 10)
    }
}
