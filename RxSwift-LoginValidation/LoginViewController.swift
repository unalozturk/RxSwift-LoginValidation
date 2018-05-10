//
//  ViewController.swift
//  RxSwift-LoginValidation
//
//  Created by Technoface on 10.05.2018.
//  Copyright © 2018 Technoface. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    let emailTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "User Name"
        tf.borderStyle = UITextBorderStyle.roundedRect
        return tf
        
    }()
    
    let passwordTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.isSecureTextEntry = true
        return tf
        
    }()
    let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let validationLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Validated"
        label.textAlignment = .center
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupControlls()
    }
    func setupView()  {
        view.addSubview(emailTF)
        [
        emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        emailTF.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        emailTF.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 20),
        emailTF.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 20),
        emailTF.heightAnchor.constraint(equalToConstant:50)
        ].forEach { $0.isActive=true}
        
        view.addSubview(passwordTF)
        [
        passwordTF.topAnchor.constraint(lessThanOrEqualTo: emailTF.bottomAnchor, constant: 20),
        passwordTF.widthAnchor.constraint(equalTo: emailTF.widthAnchor),
        passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        passwordTF.heightAnchor.constraint(equalToConstant:50)
        ].forEach { $0.isActive=true}
        
        view.addSubview(loginButton)
        [
        loginButton.topAnchor.constraint(lessThanOrEqualTo: passwordTF.bottomAnchor, constant: 20),
        loginButton.widthAnchor.constraint(equalTo: passwordTF.widthAnchor),
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        loginButton.heightAnchor.constraint(equalToConstant:50)
        ].forEach { $0.isActive=true}
        
        
        view.addSubview(validationLbl)
        [
        validationLbl.topAnchor.constraint(lessThanOrEqualTo: loginButton.bottomAnchor, constant: 20),
        validationLbl.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
        validationLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        validationLbl.heightAnchor.constraint(equalToConstant:50)
        ].forEach { $0.isActive=true }
    }
    func setupControlls() {
        _ = emailTF.rx.text.map {$0 ?? "" }.bind(to: loginViewModel.emailText)
        _ = passwordTF.rx.text.map {$0 ?? "" }.bind(to: loginViewModel.passwordText)
        _ = loginViewModel.isValid.bind(to: loginButton.rx.isEnabled)
        
        loginViewModel.isValid.subscribe(onNext: { (isValid) in
            self.validationLbl.text = isValid ? "Enabled" : "Not Enabled"
            self.validationLbl.textColor = isValid ? .green : .red
            
            self.loginButton.backgroundColor = isValid ? .green : .red
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
  
    
}

