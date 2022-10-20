//
//  ViewController.swift
//  ImgApp (parse)
//
//  Created by Ferhat Adiyeke on 15.10.2022.
//

import UIKit
import Parse

class ViewController: UIViewController {

    
    @IBOutlet var kullaniciAdiText: UITextField!
    @IBOutlet var parolaGiriniz: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }


    @IBAction func girisYapTiklandi(_ sender: Any) {
        
        if kullaniciAdiText.text != "" && parolaGiriniz.text != "" {
            PFUser.logInWithUsername(inBackground: kullaniciAdiText.text!, password: parolaGiriniz.text!){
                (user, error) in
                if error != nil {
                    self.hataMesajiGoster(title: "Hata", message: error?.localizedDescription ?? "Hata")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        } else {
            self.hataMesajiGoster(title: "Hata", message: "Kullanıcı Adı ve Parola Girmelisiniz!")
        }
    }
    
    
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        
        if kullaniciAdiText.text != "" && parolaGiriniz.text != "" {
            let user = PFUser()
            user.username = kullaniciAdiText.text!
            user.password = parolaGiriniz.text!
            
            user.signUpInBackground { (success, error) in
                
                if error != nil {
                    self.hataMesajiGoster(title: "Hata!", message: error?.localizedDescription ?? "Hata")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                }
            }
            
            
        }else {
            hataMesajiGoster(title: "Hata!", message: "Kullanıcı Adı ve Parola Girmelesiniz.")
            
        }

    }
    
    func hataMesajiGoster(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

