//
//  LoginViewModel.swift
//  RxSwift-LoginValidation
//
//  Created by Technoface on 10.05.2018.
//  Copyright © 2018 Technoface. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    var isValid : Observable <Bool> {
        return Observable.combineLatest(emailText.asObservable(),passwordText.asObservable()){email,password in email.count >= 3 && password.count >= 3 }
    }
}
