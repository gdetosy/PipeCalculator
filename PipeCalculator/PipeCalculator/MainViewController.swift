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
   
    var usd: String = ""
    var eur: String = ""
    let url = "https://www.nbrb.by/api/exrates/rates?periodicity=0"

    @IBOutlet var diametrTextField: UITextField!

    @IBOutlet var tolshinaTextField: UITextField!

    @IBOutlet var dlinaTextField: UITextField!

    @IBOutlet var heightTextField: UITextField!

    @IBOutlet var nextButton: UIButton!

    @IBAction func Diametr(_ sender: UITextField) {
        guard let diametr = Float(diametrTextField.text!),
              Float(diametrTextField.text!) ?? 0 >= 0
        else { diametrTextField.text?.removeAll()
            return
        }
        massa()
        print(diametr)
    }

    @IBAction func tolshina(_ sender: UITextField) {
        guard let tolshina = Float(tolshinaTextField.text!), Float(tolshinaTextField.text!) ?? 0 < Float(diametrTextField.text!) ?? 0


        else {
            tolshinaTextField.text?.removeAll()
            return
        }
        massa()
        print(tolshina)
    }

    @IBAction func dlina(_ sender: UITextField) {
        guard let dlina = Float(dlinaTextField.text!) else { dlinaTextField.text?.removeAll()
            return
        }
        massa()
        print(dlina)
    }

    @IBAction func height(_ sender: UITextField) {
        if
            diametrTextField.text!.isEmpty || tolshinaTextField.text!.isEmpty || dlinaTextField.text!.isEmpty
        {
            nextButton.isEnabled = false
        }

        else {
            nextButton.isEnabled = true
        }
    }

    // MARK: - raschet po kursu

    @IBAction func raschet(_ sender: UIButton) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        getPrice(url:url)
    }

    // MARK: - formula rascheta massa

    func massa() {
        guard let diametr = Float(diametrTextField.text!),
              let stenka = Float(tolshinaTextField.text!),
              let metraj = Float(dlinaTextField.text!)
        else { return }
        let massa1 = ((diametr - stenka) * stenka * 0.02466 * metraj) / 1000
        heightTextField.text = "\(round(massa1 * 100000) / 100000)"
        print(massa1)
    }

    func lenght() {
        guard let diametr = Float(diametrTextField.text!),
              let stenka = Float(tolshinaTextField.text!),

              let massa = Float(heightTextField.text!)
        else { return }

        let metraj1 = massa * 1000 / (diametr - stenka) * 0.0246
        heightTextField.text = "\(round(metraj1 * 100000) / 100000)"
        print(metraj1)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "curency":
            prepareEditScreen(segue) default: break
        }
    }

    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? CurrencyViewController else {
            return
        }
        destinationController.diametr = Float(diametrTextField.text!)!
        
        destinationController.tolshina = Float(tolshinaTextField.text!)!
        
        destinationController.dlina = Float(dlinaTextField.text!)!
        
        destinationController.height = Float(heightTextField.text!)!
        
        destinationController.usd = usd
   
        destinationController.eur = eur
    }
   
    func getPrice(url: String) {
        AF.request(url).responseJSON { [weak self] response in switch response.result {
        case .success(let value):
            let json = JSON(value)

            self?.usd = "\(json[7, "Cur_OfficialRate"])"
            self?.eur = "\(json[9, "Cur_OfficialRate"])"

        case .failure:
            print("error")
        }
        }
    }
    
    
    
    
    
    
}
