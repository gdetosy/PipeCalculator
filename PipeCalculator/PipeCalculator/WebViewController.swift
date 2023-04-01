//
//  WebViewController.swift
//  PipeCalculator
//
//  Created by tosy on 1.04.23.
//

import UIKit
import WebKit
final class WebViewController: UIViewController {
    let url = Url()
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        web()
    }

    private func web() {
        let url = URL(string: url.urlPipe)
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
    }
}
