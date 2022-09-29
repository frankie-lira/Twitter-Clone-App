//
//  LoginViewController.swift
//  Twitter
//
//  Created by Francisco Lira on 9/29/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        //Initialize URL to have clean code
        //We obtianed the URL from the API Twitter Developer website
        let myURL = "https://api.twitter.com/oauth/request_token"
    
        //TwittweAPICaller is a build in funtion that can be foudn in the corespodning folder which allows teh button to connect to the API to retrieve token
        TwitterAPICaller.client?.login(url: myURL, success: {
            //Perform Segue
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { Error in
            print("Could Not Login")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
