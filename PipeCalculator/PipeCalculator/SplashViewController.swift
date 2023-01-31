//
//  ViewController.swift
//  PipeCalculator
//
//  Created by tosy on 28.01.23.
//

import Alamofire
import SwiftyJSON
import UIKit

class SplashViewController: UIViewController {
    @IBOutlet var label: UILabel!
    let urlDate = string()
   
    override func viewDidLoad() {
        getQoute(url: urlDate)
        super.viewDidLoad()
        
        // MARK: - Intro splash with qoute and easy animation transition 2 next view
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.performSegue(withIdentifier: "Splash", sender: nil)
        }
    }
    
    // MARK: - paring func for random facts on this date
    
    func getQoute(url: String) {
        AF.request(url).responseJSON { [weak self] response in switch response.result {
        case .success(let value):
            let json = JSON(value)
            print(json)
            self?.label.text = "\(json["text"])"
        case .failure(let error):
            print(error)
        }
        }
    }
}
