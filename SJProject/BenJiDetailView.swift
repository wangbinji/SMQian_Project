//
//  BenJiDetailView.swift
//  SJProject
//
//  Created by 王斌绩 on 2021/4/20.
//

import UIKit
import WebKit
import Combine
import NaturalLanguage
import CoreML


class BenJiDetailView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        
        let userNameField = UITextField.init(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        userNameField.placeholder = "please input username"
        userNameField.borderStyle = .roundedRect
        view.addSubview(userNameField)
        
        let passwordField = UITextField.init(frame: CGRect(x: 100, y: Double(userNameField.frame.maxY) + 50, width: 200, height: 50))
        passwordField.placeholder = "please input password"
        passwordField.borderStyle = .roundedRect
        view.addSubview(passwordField)
        
        
        let justPublish = Just("Hello")
        
        
    }
}
