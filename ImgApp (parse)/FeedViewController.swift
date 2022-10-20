//
//  FeedViewController.swift
//  ImgApp (parse)
//
//  Created by Ferhat Adiyeke on 16.10.2022.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    var postDizisi =  [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        verileriAl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(verileriAl), name: NSNotification.Name(rawValue: "yeniPost"), object: nil)
    }
    
    @objc func verileriAl() {
        
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("creadetAt")
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Hata")
                
            }else {
                if objects != nil {
                    if objects!.count > 0 {
                        self.postDizisi.removeAll(keepingCapacity: false)
                        
                        
                        for object in objects! {
                            if  let kullaniciIsmi = object.object(forKey: "postsahibi") as? String {
                                if let kullaniciYorumu = object.object(forKey: "postyorumu") as?  String {
                                    if let kullaniciGorsel = object.object(forKey: "postgorsel") as? PFFileObject {
                                        let post =  Post(kullaniciAdi: kullaniciIsmi, kullaniciYorumu: kullaniciYorumu, kullaniciGorsel: kullaniciGorsel)
                                        self.postDizisi.append(post)
                                    }
                                }
                            }
                            
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    func hataMesaji(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.kullaniciAdiLabel.text = postDizisi[indexPath.row].kullaniciAdi
        cell.kullaniciYorumLabel.text = postDizisi[indexPath.row].kullaniciYorumu
        postDizisi[indexPath.row].kullaniciGorsel.getDataInBackground { (data, error) in
            if error  == nil {
                if let data  = data {
                    cell.postImageView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }

}
