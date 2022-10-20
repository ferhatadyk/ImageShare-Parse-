//
//  SettingsViewController.swift
//  ImgApp (parse)
//
//  Created by Ferhat Adiyeke on 17.10.2022.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func cikisYapTiklandi(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription ?? "Hata", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                self.performSegue(withIdentifier: "toViewController", sender: nil)
            }
        }
    }
    
}
