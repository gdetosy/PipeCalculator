//
//  MainViewController.swift
//  PipeCalculator
//
//  Created by tosy on 28.01.23.
//

import UIKit

class MainViewController: UIViewController, UITextViewDelegate {
 
    private func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == diametrTextField {
                print("You edit myTextField")
            }
        }
    
    
    @IBOutlet var diametrTextField: UITextField!
    
    @IBOutlet var tolshinaTextField: UITextField!
    
    @IBOutlet var dlinaTextField: UITextField!
    
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var nextButton: UIButton!

    @IBAction func Diametr(_ sender: Any) {
if diametrTextField.text!.isEmpty || tolshinaTextField.text!.isEmpty {
    // set the button state to disabled
    nextButton.isEnabled = false
  // otherwise
  } else {
    // set the button state to enabled
    nextButton.isEnabled = true
    }
  

        guard let diametr = Double(diametrTextField.text!)
        else { diametrTextField.text?.removeAll()
            return
        }

        print(diametr)
    }
//
    @IBAction func tolshina(_ sender: UITextField) {

        guard let tolshina = Double(tolshinaTextField.text!), Double(tolshinaTextField.text!) ?? 0 < Double(diametrTextField.text!) ?? 0
      
        else { tolshinaTextField.text?.removeAll()
            return
        }
        print(tolshina)
    }

    @IBAction func dlina(_ sender: UITextField) {
        guard let dlina = Double(dlinaTextField.text!) else { dlinaTextField.text?.removeAll()
            return
        }
        print(dlina)
    }

    @IBAction func raschet(_ sender: UIButton) {
     massa()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
       
    }
//    massa = ((diametr - stenka) * stenka * 0,02466 * metraj) / 1000

    func massa() {
       guard let diametr = Double(diametrTextField.text!),
        let stenka = Double(tolshinaTextField.text!),
        let metraj = Double(dlinaTextField.text!)
        else {return}
        let massa1 = (((diametr) - stenka) * stenka * 0.02466 * metraj) / 1000
        heightTextField.text = "\(massa1)"
        print(massa1)
    }
//    func activeBtn() {
//    { if diametrTextField.text!.isEmpty == false, tolshinaTextField.text!.isEmpty == false, dlinaTextField.text!.isEmpty == false {
//        nextButton.isHidden = diametrTextField.text!.isEmpty && tolshinaTextField.text!.isEmpty &&
//        dlinaTextField.text!.isEmpty
//    }
//    textField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
//                              for: .editingChanged)
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
