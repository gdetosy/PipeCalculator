//
//  MainViewController.swift
//  PipeCalculator
//
//  Created by tosy on 28.01.23.
//

import Alamofire
import SwiftyJSON
import UIKit

class MainViewController: UIViewController {
    var array: [String] = []
    var usd: String = ""
    var eur: String = ""
    let url = "https://www.nbrb.by/api/exrates/rates?periodicity=0"
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var dlinaLabel: UILabel!
    
    @IBOutlet var diametrTextField: UITextField!
    
    @IBOutlet var tolshinaTextField: UITextField!
    
    @IBOutlet var dlinaTextField: UITextField!
    
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var heightMetr: UILabel!
    
    @IBAction func diametr(_ sender: UITextField) {
        guard let diametr = Float(diametrTextField.text!),
              Float(diametrTextField.text!) ?? 0 >= 0
        else { diametrTextField.text?.removeAll()
            return
        }
        if dlinaLabel.text == "Длинна, m" {
            massa()
        } else
        { lenght() }
        print(diametr)
    }
    
    @IBAction func tolshina(_ sender: UITextField) {
        guard let tolshina = Float(tolshinaTextField.text!), Float(tolshinaTextField.text!) ?? 0 < Float(diametrTextField.text!) ?? 0
                
        else {
            tolshinaTextField.text?.removeAll()
            return
        }
        if dlinaLabel.text == "Длинна, m" {
            massa()
        } else
        { lenght() }
        print(tolshina)
    }
    
    @IBAction func dlina(_ sender: UITextField) {
        guard let dlina = Float(dlinaTextField.text!) else { dlinaTextField.text?.removeAll()
            return
        }
        if dlinaLabel.text == "Длинна, m" {
            massa()
        } else
        { lenght() }
        
        print(dlina)
    }
    
    @IBAction func height(_ sender: UITextField) {
        if
            diametrTextField.text!.isEmpty || tolshinaTextField.text!.isEmpty || dlinaTextField.text!.isEmpty
        {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    
    // MARK: - raschet po kursu
    
    @IBAction func raschet(_ sender: UIButton) {
        if array.count == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editScreen = storyboard.instantiateViewController(withIdentifier:
                "CurrencyViewController") as! CurrencyViewController
            editScreen.diametr = Float(diametrTextField.text!)!
            editScreen.tolshina = Float(tolshinaTextField.text!)!
            editScreen.dlina = Float(dlinaTextField.text!)!
            editScreen.height = Float(heightTextField.text!)!
            editScreen.usd = usd
            editScreen.eur = eur
            
            self.navigationController?.pushViewController(editScreen, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editScreen = storyboard.instantiateViewController(withIdentifier:
                "PriceViewController") as! PriceViewController
            editScreen.diametr = Float(diametrTextField.text!)!
            editScreen.tolshina = Float(tolshinaTextField.text!)!
            editScreen.dlina = Float(dlinaTextField.text!)!
            editScreen.height = Float(heightTextField.text!)!
            self.navigationController?.pushViewController(editScreen, animated: true)
        }
    }
    
    @IBAction func about(_ sender: Any) {
        if dlinaLabel.text == "Длинна, m" { alert() }
        else { alert1() }
    }
    
    @IBAction func segmentControll(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            dlinaLabel.text = "Длинна, m"
            heightLabel.text = "Вес, тн"
            diametrTextField.text?.removeAll()
            tolshinaTextField.text?.removeAll()
            dlinaTextField.text?.removeAll()
            heightTextField.text?.removeAll()
        case 1:
            dlinaLabel.text = "Вес, тн"
            heightLabel.text = "Длинна, m"
            diametrTextField.text?.removeAll()
            tolshinaTextField.text?.removeAll()
            dlinaTextField.text?.removeAll()
            heightTextField.text?.removeAll()
        default: print("lol")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dlinaLabel.text = "Длинна, m"
        getPrice(url: url)
    }
    
    // MARK: - formula rascheta massa
    
    func massa() {
        guard let diametr = Float(diametrTextField.text!),
              let stenka = Float(tolshinaTextField.text!),
              let metraj = Float(dlinaTextField.text!)
        else { return }
        let massa1 = ((diametr - stenka) * stenka * 0.02466 * metraj) / 1000
        let heightMetrs = ((diametr - stenka) * stenka * 0.02466 * 1) / 1000
        heightTextField.text = "\(round(massa1 * 100000) / 100000)"
        heightMetr.text = "Вес 1 метра = \(round(heightMetrs * 100000) / 100000) тн. = \((round(heightMetrs * 100000) / 100000) * 1000) кг."
    }
    
    func lenght() {
        guard let diametr = Float(diametrTextField.text!),
              let stenka = Float(tolshinaTextField.text!),
              let massa = Float(dlinaTextField.text!)
        else { return }
        let metraj1 = massa * 1000 / ((diametr - stenka) * 0.0246 * stenka)
        let heightMetrs = ((diametr - stenka) * stenka * 0.02466 * 1) / 1000
        heightTextField.text = "\(round(metraj1 * 1000) / 1000)"
        heightMetr.text = "Вес 1 метра = \(round(heightMetrs * 100000) / 100000) тн. = \((round(heightMetrs * 100000) / 100000) * 1000) кг."
        print(metraj1)
    }
    
    func getPrice(url: String) {
        AF.request(url).responseJSON { [weak self] response in switch response.result {
        case .success(let value):
            let json = JSON(value)
            
            self?.usd = "\(json[7, "Cur_OfficialRate"])"
            self?.eur = "\(json[9, "Cur_OfficialRate"])"
            self?.array.append("\(json[7, "Cur_OfficialRate"])")
            self?.array.append("\(json[9, "Cur_OfficialRate"])")
        case .failure:
            print("error")
        }
        }
    }

    func alert() {
        let alert = UIAlertController(title: "Формула расчета", message: "Трубный калькулятор  производит расчет веса круглой электросварной трубы по формуле:                                      Масса трубы = ((диаметр трубы  - толщина стенки) х толщина стенки х 0.02466 х метраж) / 1000",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    func alert1() {
        let alert = UIAlertController(title: "Формула расчета", message: "Трубный калькулятор  производит расчет веса круглой электросварной трубы по формуле:                                     Длинна трубы = масса * 1000 / ((диаметр трубы - толщина стенки) * 0.0246 * толщина стенки)",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
