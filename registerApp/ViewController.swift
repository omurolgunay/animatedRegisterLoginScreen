//
//  ViewController.swift
//  registerApp
//
//  Created by omur olgunay on 24.08.2019.
//  Copyright © 2019 omur olgunay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var particalImageView: UIImageView!
    @IBOutlet weak var veritcalLineView: UIView!{
        didSet{
            self.veritcalLineView.clipsToBounds = true
            self.veritcalLineView.layer.cornerRadius = 2.0
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            self.loginButton.clipsToBounds = true
            self.loginButton.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet weak var registerButton: UIButton!{
        didSet{
            self.registerButton.clipsToBounds = true
            self.registerButton.layer.cornerRadius = 5.0
        }
    }
    
    //MARK: - IBActions
    @IBAction func goRegisterView(_ sender: Any) {
        goRegisterScreen(delay: 0.5)
    }
    
    @IBAction func goLoginView(_ sender: Any) {
        goLoginScreen(delay: 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Gesture Recognizers
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGestureCalled))
        swipeUpGesture.direction = .up
        view.addGestureRecognizer(swipeUpGesture)
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGestureCalled))
        swipeDownGesture.direction = .down
        view.addGestureRecognizer(swipeDownGesture)
        
        let dismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboard)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // When didApper register form can not shows up as a default
        self.registerView.frame.origin.y = self.view.frame.height
    }
    //MARK:- Screen Animation
    func goRegisterScreen(delay:Double){
        let yPositionOfFocusScreen = (view.frame.height / 2) - (self.registerView.frame.height / 2)
        UIView.animate(withDuration: 1.0, delay: delay, options: .curveEaseOut, animations: {
            self.registerView.frame.origin.y = yPositionOfFocusScreen
            self.loginView.frame.origin.y = -self.loginView.frame.height
            self.animateAllImages(direction: 1)
            self.veritcalLineView.backgroundColor = #colorLiteral(red: 0.9688373208, green: 0.5204376578, blue: 0.001740501961, alpha: 1)
        }, completion: { finished in
            // Do someting when animation completed
        })
    }
    
    func goLoginScreen(delay:Double){
        let yPositionOfFocusScreen = (view.frame.height / 2) - (self.registerView.frame.height / 2)
        UIView.animate(withDuration: 1.0, delay: delay, options: .curveEaseOut, animations: {
            self.loginView.frame.origin.y = yPositionOfFocusScreen
            self.registerView.frame.origin.y = self.view.frame.height
            self.animateAllImages(direction: -1)
            self.veritcalLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }, completion: { finished in
            // Do someting when animation completed
        })
    }
    
    func animateAllImages(direction:CGFloat){
        self.particalImageView.transform = CGAffineTransform(rotationAngle: 90 * direction)
    }
    
    //MARK:- Gestures Function
    @objc func swipeGestureCalled(recognizer:UISwipeGestureRecognizer){
        if recognizer.direction == .up{
            goRegisterScreen(delay: 0)
        }else if recognizer.direction == .down{
            goLoginScreen(delay: 0)
        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

