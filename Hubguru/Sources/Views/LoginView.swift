//
//  LoginView.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import EasyPeasy

final class LoginView: UIView {
    
    let signInButton = UIButton.signInButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hex: 0x262626)
        
        addSubview(signInButton)
        signInButton.easy.layout(
            [Center(CGPoint(x: 0, y: -100)),
             Height(46),
             Width(250)]
        )
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension UIButton {
    
    class func signInButton() -> UIButton {
        let signInButton = UIButton(type: .custom)
        signInButton.setImage(UIImage(named: "ico-sign-in-github"), for: .normal)
        signInButton.setTitle(NSLocalizedString("LoginScreen.signInButtonTitle", comment: "Sign in using Github"), for: .normal)
        signInButton.layer.cornerRadius = 8
        signInButton.layer.borderColor = UIColor(hex: 0x464646).cgColor
        signInButton.layer.borderWidth = 1
        signInButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        return signInButton
    }
}
