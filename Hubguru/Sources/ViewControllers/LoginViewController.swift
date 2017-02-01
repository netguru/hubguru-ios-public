//
//  LoginViewController.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    fileprivate var loginView: LoginView {
        return view as! LoginView
    }
    
    override func loadView() {
        view = LoginView(frame: CGRect.zero)
    }
}
