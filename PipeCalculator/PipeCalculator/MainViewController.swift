//
//  MainViewController.swift
//  PipeCalculator
//
//  Created by tosy on 28.01.23.
//

import UIKit

class MainViewController: UIViewController {
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
//              let metraj = Float(dlinaTextField.text!),
              let massa = Float(heightTextField.text!)
        else { return }
//        let  = ((diametr - stenka) * stenka * 0.02466 * metraj) / 1000
        let metraj1 = massa * 1000 / (diametr - stenka) * 0.0246
        heightTextField.text = "\(round(metraj1 * 100000) / 100000)"
        print(metraj1)
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
