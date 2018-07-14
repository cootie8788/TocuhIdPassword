//
//  ViewController.swift
//  TocuhIdPassword
//
//  Created by 林沂諺 on 2018/6/26.
//  Copyright © 2018年 AppleCode. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationVC: UIViewController {
    
    @IBAction func useTouchIDButtonWasPressed(_ sender: Any) {
        let authenticationContext = LAContext()
        var error:NSError?
        
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //Touch ID navigation to sucess VC, handling  errors
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "使用指Touch ID 進入帳號管理") { (success, error) in
                if success {
                    //Navigate to succes VC
                    self.navigateToAuthenticatedVC()
                    
                }else {
                    if let error = error as NSError? {
                        //Display an error of apecifif type
                        let message = self.errorMessageForLAerrorCode(errorCode: error.code)
                        self.ShowAlertViewAfterEvaluatingPolicyWithMessage(message: message)
                    }
                }
            }
        }else {
            showAlertViewForNoBiometrics()
            return
        }
        
    }
    
    func ShowAlertViewAfterEvaluatingPolicyWithMessage(message: String) {
        showAlertWithTitle(title: "Error", message: message)
    }
    
    func errorMessageForLAerrorCode(errorCode: Int) -> String {
        var message = ""
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.authenticationFailed.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.invalidContext.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.invalidContext.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.passcodeNotSet.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.touchIDLockout.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.touchIDNotAvailable.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.userCancel.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.userFallback.rawValue:
            message = "Authentication was cancelled by application"
            
        default:
            message = "Did faild"
        }
        return message
        
        
    }
    
    func navigateToAuthenticatedVC() {
        if let loggedInVC = storyboard?.instantiateViewController(withIdentifier: "loggedInVC"){
            DispatchQueue.main.sync {
                self.navigationController?.pushViewController(loggedInVC, animated: true)
            }
            
        }
        
    }
    
    
    func showAlertViewForNoBiometrics() {
        showAlertWithTitle(title: "Error", message: "This divice not have a Touch ID Sensor")
    }
    
    func showAlertWithTitle(title: String, message: String){
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVc.addAction(okAction)
        self.present(alertVc, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

