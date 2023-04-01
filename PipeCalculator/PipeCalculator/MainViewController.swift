//
//  MainViewController.swift
//  PipeCalculator
//
//  Created by tosy on 28.01.23.
//
import Alamofire
import Spring
import SwiftyJSON
import UIKit

final class MainViewController: UIViewController, UITextFieldDelegate {
    var array: [String] = []
    var arrayBefore: [String] = []
    let url = Url()
    @IBOutlet var smallView: UIView!
    
    @IBOutlet var bigView: SpringView!
    var currency = Currency()
    
    @IBOutlet var okThick: UIImageView!
    
    @IBOutlet var okLenght: UIImageView!
    
    @IBOutlet var okWeght: UIImageView!
    
    @IBOutlet var ok: UIImageView!
   
    @IBOutlet var but: UIButton!
    
    @IBOutlet var diametrLbl: UILabel!
    
    @IBOutlet var thicknessLbl: UILabel!
    
    @IBOutlet var heightLabel: UILabel!
   
    @IBOutlet var dlinaLabel: UILabel!
    
    @IBOutlet var diametrTextField: SpringTextField!
    
    @IBOutlet var tolshinaTextField: SpringTextField!
    
    @IBOutlet var dlinaTextField: SpringTextField!
    
    @IBOutlet var heightTextField: SpringTextField!
    
    @IBOutlet var heightMetr: SpringLabel!
    
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
            bigView.animation = Animations.shake.rawValue
            bigView.force = 0.25
            bigView.animate()
            segmentCaseOne()
        case 1:
            segmentCaseTwo()
            bigView.animation = Animations.shake.rawValue
            bigView.force = 0.25
            bigView.animate()
        default: print("lol")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        getPrice(url: url.url)
        getPriceBefore(url: url.urlBeforeDay)
        self.hideKeyboardWhenTappedAround()
        viewSettings()
    }
   
    // MARK: - formula rascheta massa
    
    private func massa() {
        guard let diametr = Float(diametrTextField.text!.replacingOccurrences(of: ",", with: ".")),
              let stenka = Float(tolshinaTextField.text!.replacingOccurrences(of: ",", with: ".")),
              let metraj = Float(dlinaTextField.text!.replacingOccurrences(of: ",", with: "."))
        else { return }
        let massa1 = ((diametr - stenka) * stenka * 0.02466 * metraj) / 1000
        let heightMetrs = ((diametr - stenka) * stenka * 0.02466 * 1) / 1000
        let kg = (diametr - stenka) * stenka * 0.02466
        heightMetr.text = "1 m weight = \(round(heightMetrs * 100000) / 100000) t = \(kg) kg."
        heightMetr.animation = Animations.fadeIn.rawValue
        heightMetr.animate()
        heightTextField.text = "\(round(massa1 * 100000) / 100000)"
    }
    
    private func lenght() {
        guard let diametr = Float(diametrTextField.text!.replacingOccurrences(of: ",", with: ".")),
              let stenka = Float(tolshinaTextField.text!.replacingOccurrences(of: ",", with: ".")),
              let massa = Float(dlinaTextField.text!.replacingOccurrences(of: ",", with: "."))
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
        guard let diametr = Float(diametrTextField.text!.replacingOccurrences(of: ",", with: ".")),
            
              diametr > 0, diametr <= 325
        else { diametrTextField.text?.removeAll(); heightMetr.text = " "
            diametrTextField.animation = Animations.shake.rawValue
            diametrTextField.force = 0.25
            diametrTextField.animate()
            heightTextField.text?.removeAll()
            ok.alpha = 0
            return
        }
        print(diametr)
        ok.alpha = 1
        if dlinaLabel.text == "Length, m" {
            massa()
        } else
        { lenght() }
    }
    
    private func tolshina() {
        guard Float(tolshinaTextField.text!.replacingOccurrences(of: ",", with: ".")) ?? 0 < Float(diametrTextField.text!.replacingOccurrences(of: ",", with: ".")) ?? 0,
              Float(tolshinaTextField.text!.replacingOccurrences(of: ",", with: ".")) ?? 0 <= 20,
              Float(tolshinaTextField.text!.replacingOccurrences(of: ",", with: ".")) != nil
                
        else {
            tolshinaTextField.animation = Animations.shake.rawValue
            tolshinaTextField.force = 0.25
            tolshinaTextField.animate()
            okThick.alpha = 0
            tolshinaTextField.text?.removeAll()
            but.isEnabled = false
            okWeght.alpha = 0
            heightTextField.text?.removeAll()
            heightMetr.text = " "
            heightMetr.animation = Animations.fadeOut.rawValue
            heightMetr.animate()
            return
        }
        
        okThick.alpha = 1
        
        if dlinaLabel.text == "Length, m" {
            massa()
        } else
        { lenght() }
    }
   
    private func dlina() {
        guard Float(dlinaTextField.text!.replacingOccurrences(of: ",", with: ".")) != nil,
              Float(dlinaTextField.text!.replacingOccurrences(of: ",", with: ".")) ?? 0 <= 100
        else {
            dlinaTextField.animation = Animations.shake.rawValue
            dlinaTextField.force = 0.25
            dlinaTextField.animate()
            dlinaTextField.text?.removeAll()
            heightTextField.text?.removeAll()
            okLenght.alpha = 0
            return
        }
        okLenght.alpha = 1
        if dlinaLabel.text == "Length, m" {
            massa()
        } else
        { lenght() }
    }
    
    private func height() {
        if
            diametrTextField.text!.isEmpty || tolshinaTextField.text!.isEmpty || dlinaTextField.text!.isEmpty
        {
            okWeght.alpha = 0
            but.isEnabled = false
        } else {
            but.isEnabled = true
            okWeght.alpha = 1
        }
    }
    
    private func about() {
        if dlinaLabel.text == "Length, m" { alert() }
        else { alert1() }
    }
    
    private func raschet() {
        if array.count == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editScreen = storyboard.instantiateViewController(withIdentifier:
                "CurrencyViewController") as! CurrencyViewController
            if dlinaLabel.text == "Length, m" {
                editScreen.currency.diametr = Float(diametrTextField.text!.replacingOccurrences(of: ",", with: "."))!
                editScreen.currency.tolshina = Float(tolshinaTextField.text!.replacingOccurrences(of: ",", with: "."))!
                editScreen.currency.dlina = Float(dlinaTextField.text!.replacingOccurrences(of: ",", with: "."))!
                editScreen.currency.height = Float(heightTextField.text!.replacingOccurrences(of: ",", with: "."))!
                editScreen.currency.usd = currency.usd
                editScreen.currency.eur = currency.eur
                editScreen.currency.eurBeforeDay = currency.eurBeforeDay
                editScreen.currency.usdBeforeDay = currency.usdBeforeDay
                self.navigationController?.pushViewController(editScreen, animated: true)
            } else {
                editScreen.currency.diametr = Float(diametrTextField.text!.replacingOccurrences(of: ",", with: "."))!
                editScreen.currency.tolshina = Float(tolshinaTextField.text!.replacingOccurrences(of: ",", with: "."))!
                editScreen.currency.height = Float(dlinaTextField.text!.replacingOccurrences(of: ",", with: "."))!
                editScreen.currency.dlina = Float(heightTextField.text!.replacingOccurrences(of: ",", with: "."))!
                editScreen.currency.usd = currency.usd
                editScreen.currency.eur = currency.eur
                editScreen.currency.eurBeforeDay = currency.eurBeforeDay
                editScreen.currency.usdBeforeDay = currency.usdBeforeDay
                self.navigationController?.pushViewController(editScreen, animated: true)
            }
        
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editScreen = storyboard.instantiateViewController(withIdentifier:
                "PriceViewController") as! PriceViewController
            editScreen.currency.diametr = Float(diametrTextField.text!.replacingOccurrences(of: ",", with: "."))!
            editScreen.currency.tolshina = Float(tolshinaTextField.text!.replacingOccurrences(of: ",", with: "."))!
            editScreen.currency.dlina = Float(dlinaTextField.text!.replacingOccurrences(of: ",", with: "."))!
            editScreen.currency.height = Float(heightTextField.text!.replacingOccurrences(of: ",", with: "."))!
            self.navigationController?.pushViewController(editScreen, animated: true)
        }
    }
    
    private func segmentCaseOne() {
        dlinaLabel.text = "Length, m"
        heightLabel.text = "Weight, t"
        diametrTextField.text?.removeAll()
        tolshinaTextField.text?.removeAll()
        dlinaTextField.text?.removeAll()
        heightTextField.text?.removeAll()
        heightTextField.attributedPlaceholder = NSAttributedString(
            string: "tn")
        dlinaTextField.attributedPlaceholder = NSAttributedString(
            string: "m")
        heightMetr.text = " "
        heightMetr.animation = Animations.fadeOut.rawValue
        heightMetr.animate()
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
        heightLabel.text = "Length, m"
        diametrTextField.text?.removeAll()
        tolshinaTextField.text?.removeAll()
        dlinaTextField.text?.removeAll()
        heightTextField.text?.removeAll()
        heightTextField.attributedPlaceholder = NSAttributedString(
            string: "m")
        dlinaTextField.attributedPlaceholder = NSAttributedString(
            string: "tn")
        heightMetr.text = " "
        heightMetr.animation = Animations.fadeOut.rawValue
        heightMetr.animate()
        height()
    }

    private func viewSettings() {
        dlinaLabel.text = "Length, m"
        bigView.layer.cornerRadius = 17
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "ing")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}
