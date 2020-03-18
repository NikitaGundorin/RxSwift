//
//  ViewController.swift
//  3. Rx
//
//  Created by Никита Гундорин on 16.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import Bond

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var sendButton: UIButton!
    
    let isEmailValid = Observable<Bool>(false)
    let isPasswordValid = Observable<Bool>(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.reactive.text
            .ignoreNils()
            .map { self.checkEmail(email: $0) }
            .bind(to: isEmailValid)
                
        passwordTextField.reactive.text
            .ignoreNils()
            .map { $0.count > 5 }
            .bind(to: isPasswordValid)
        
        isEmailValid.combineLatest(with: isPasswordValid)
            .map {
                !$0 && self.loginTextField.text!.count > 0 ? "Invalid email" :!$1 && self.passwordTextField.text!.count > 0 && $0 ? "Too short password" : ""
            }
            .bind(to: errorLabel.reactive.text)
        
        isEmailValid.combineLatest(with: isPasswordValid)
            .map { $0 && $1 }
            .bind(to: sendButton.reactive.isEnabled)
    }
    
    func checkEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
