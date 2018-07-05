//
//  ViewController.swift
//  SDNetworkExample
//
//  Created by Seth on 5/24/18.
//  Copyright © 2018 aii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = ViewModel()
    
    @IBOutlet weak var debug_textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    internal func updateConsole(_ newText: String) {
        let updated = debug_textView.text+newText+"\n"
        debug_textView.text = updated
        debug_textView.scrollRectToVisible(CGRect(
            x: debug_textView.contentSize.width - 1,
            y: debug_textView.contentSize.height - 1,
            width: 1,
            height: 1), animated: true)
    }
    
    @IBAction func resetConsole(_ sender: Any) {
        debug_textView.text = ""
    }
    
    @IBAction func fetchConfig(_ sender: Any) {
        
        viewModel.fetchConfig() { (config: AppConfig?, error) in
            DispatchQueue.main.async {
                self.updateConsole("Error: \(String(describing: error))")
                self.updateConsole("Config: \(String(describing: config))")
                self.updateConsole("\tShow Ads: \(String(describing: config?.showAds))")
                self.updateConsole("\tCurrent Version: \(String(describing: config?.currentVersion))")
                self.updateConsole("\n    --------    \n")
            }
        }
    }
    
    @IBAction func fetchToken(_ sender: Any) {
        viewModel.fetchToken() { (token: Token?, error) in
            DispatchQueue.main.async {
                self.updateConsole("Error: \(String(describing: error))")
                self.updateConsole("\tAccessToken: \(String(describing: token?.accessToken))")
                self.updateConsole("\tTokenType: \(String(describing: token?.tokenType))")
                self.updateConsole("\tiss: \(String(describing: token?.iss))")
                self.updateConsole("\tExpiresIn: \(String(describing: token?.expiresIn))")
                self.updateConsole("\n    --------    \n")
            }
        }
    }
    
    @IBAction func loginUser(_ sender: Any) {
        viewModel.login(email: "demo", password: "demo") { (user: User?, error) in
            DispatchQueue.main.async {
                self.updateConsole("Error: \(String(describing: error))")
                self.updateConsole("User: \(String(describing: user?.identifier))")
                self.updateConsole("Name: \(String(describing: user?.firstName))")
                self.updateConsole("\n    --------    \n")
            }
        }
    }
    
}
