//
//  FeedTableViewCell.swift
//  ImgApp (parse)
//
//  Created by Ferhat Adiyeke on 17.10.2022.
//

import UIKit
import Parse

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var kullaniciAdiLabel: UILabel!
    
    @IBOutlet var postImageView: UIImageView!
    
    @IBOutlet var kullaniciYorumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
