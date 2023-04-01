//
//  WebViewController.swift
//  PipeCalculator
//
//  Created by tosy on 1.04.23.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: "https://aksvil.by/truby-stalnyye/")
                    let requestObj = URLRequest(url: url!)
        webView.load(requestObj)

        // Do any additional setup after loading the view.
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
