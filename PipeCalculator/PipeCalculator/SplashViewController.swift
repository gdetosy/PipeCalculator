//
//  ViewController.swift
//  PipeCalculator
//
//  Created by tosy on 28.01.23.
//

import Alamofire
import SwiftyJSON
import UIKit

final class SplashViewController: UIViewController {
    let urlDate = string()
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        getQoute(url: urlDate)
        viewSetting()
        super.viewDidLoad()
        
        // MARK: - Intro splash with qoute and easy animation transition 2 next view
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5) {
            self.performSegue(withIdentifier: "Splash", sender: nil)
        }
    }
    
    // MARK: - paring func for random facts on this date
    let text = Qoute.allCases.randomElement()!.rawValue
    func getQoute(url: String) {
        AF.request(url).responseJSON { [weak self] response in switch response.result {
        case .success(let value):
            let json = JSON(value)
            print(json)
            self?.label.text = "\(json["text"])"
            
        case .failure:
            self?.label.text = "\(self!.text)" + " " + "Steve Jobs"
        }
        }
    }

    func viewSetting() {
        label.font = UIFont(name: "Minecrafter", size: 40)
    }

}
