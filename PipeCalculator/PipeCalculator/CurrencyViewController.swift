//
//  CurrencyViewController.swift
//  PipeCalculator
//
//  Created by tosy on 21.02.23.
//

import UIKit

class CurrencyViewController: UIViewController {
    var diametr: Float = 0
    var tolshina: Float = 0
    var dlina: Float = 0
    var height: Float = 0
    @IBOutlet var pipeLabel: UILabel!
    
    @IBOutlet var lenghtHeightLabel: UILabel!
   
    @IBOutlet var priceTextField: UITextField!
    
    @IBOutlet var segmentConrol: UISegmentedControl!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
print(height)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {}
    
    @IBAction func segmentControl(_ sender: Any) {}
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
