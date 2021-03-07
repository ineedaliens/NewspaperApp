//
//  WebVC.swift
//  News
//
//  Created by Евгений on 07.03.2021.
//

import UIKit
import WebKit

class WebVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var urlPage = ""
    var head: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.allowsBackForwardNavigationGestures = true
        goToUrl(with: urlPage)
        title = head
    }
    

    func goToUrl(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
