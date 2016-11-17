//
//  LoginViewController.swift
//  LocalSearchTemp
//
//  Created by Amit Gupta on 14/08/16.
//  Copyright © 2016 harman. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn




class LoginViewController: UIViewController,  FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate{
    
    var googleUser: GIDGoogleUser!
    @IBOutlet weak var fbLoginButton:FBSDKLoginButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor   =   UIColor.purpleColor()
        self.addLoginButtons()
        

//        if let accessToken = FBSDKAccessToken.current {
//            // User is logged in, use 'accessToken' here.
//        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (LSTUserProfile.sharedInstance.userName.characters.count>0) {
            //self .performSegueWithIdentifier("LSTLogin", sender: self);
        }
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//      @IBAction func loginTapped(sender: AnyObject){
//        self .performSegueWithIdentifier("LSTLogin", sender: self);
//    }

    
    //MARK:
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        self .performSegueWithIdentifier("LSTLogin", sender: self);
    }
    

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        
    }
    
    //MARK:
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        //self .performSegueWithIdentifier("LSTLogin", sender: self);
        self.presentViewController(viewController, animated: true, completion: {
                self .performSegueWithIdentifier("LSTLogin", sender: self);
            })
    }
    
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil){
            // Perform any operations on signed in user here.
            
            LSTUserProfile.sharedInstance.userName = user.userID                  // For client-side use only!
            LSTUserProfile.sharedInstance.token = user.authentication.idToken // Safe to send to the server
            LSTUserProfile.sharedInstance.fullName = user.profile.name
            LSTUserProfile.sharedInstance.firstName = user.profile.givenName
            LSTUserProfile.sharedInstance.familyName = user.profile.familyName
            LSTUserProfile.sharedInstance.email = user.profile.email
            
            self .performSegueWithIdentifier("LSTLogin", sender: self);
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        
    }

    
    
    
    //MARK:
    func addLoginButtons (){
        let loginButton = FBSDKLoginButton()
        loginButton.delegate    =   self
        loginButton.readPermissions  =   []
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        let horizontalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -180)
        view.addConstraint(verticalConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 250)
        view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        view.addConstraint(heightConstraint)
        
        
        let gLoginButton = GIDSignInButton()
        
        gLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gLoginButton)
        
        let gHorizontalConstraint = NSLayoutConstraint(item: gLoginButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        view.addConstraint(gHorizontalConstraint)
        
        let gVerticalConstraint = NSLayoutConstraint(item: gLoginButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -120)
        view.addConstraint(gVerticalConstraint)
        
        let gWidthConstraint = NSLayoutConstraint(item: gLoginButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 250)
        view.addConstraint(gWidthConstraint)
    }
}

