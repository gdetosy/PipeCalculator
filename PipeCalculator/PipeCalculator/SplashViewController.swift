//
//  ViewController.swift
//  PipeCalculator
//
//  Created by tosy on 28.01.23.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//       MARK: -  Splash with qoute and easy animation transition 2 next view
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.performSegue(withIdentifier: "Splash", sender: nil)
            
            
            }
    }
}
