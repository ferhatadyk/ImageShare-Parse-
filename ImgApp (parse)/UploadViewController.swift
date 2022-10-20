//
//  UploadViewController.swift
//  ImgApp (parse)
//
//  Created by Ferhat Adiyeke on 16.10.2022.
//

import UIKit
import Parse

class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var paylasTiklandi: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //klavyeyi kapatmak için
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiSakla))
        view.addGestureRecognizer(keyboardRecognizer)
        
        // resimle etkileşim kurmak için
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        paylasTiklandi.isEnabled = false
    }
    

    @objc func gorselSec() {
        
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        paylasTiklandi.isEnabled = true
    }
    
    
    @objc func klavyeyiSakla()  {
        
        view.endEditing(true)
    }
    
    @IBAction func paylasClick(_ sender: Any) {
        
        paylasTiklandi.isEnabled = false
        
        let post = PFObject(className: "Post")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        if let data = data {
            
            if PFUser.current() != nil {
                let parseImage = PFFileObject(name: "image.jpg", data: data)
              
                post["postgorsel"] = parseImage
                post["postyorum"] = textField.text!
                post["postsahibi"] = PFUser.current()!.username!
                
                
                post.saveInBackground { (success, error) in
                    if error != nil {
                        let alert  = UIAlertController(title: "Hata", message: error?.localizedDescription ?? "Hata", preferredStyle: .alert )
                        
                        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        self.textField.text = ""
                        self.imageView.image = UIImage(named: "imgselected")
                        self.tabBarController?.selectedIndex = 0
                        
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "yeniPost"), object: nil)
                    } 
                }
            }
            }
            
        }
        
        
    
    
    

}
