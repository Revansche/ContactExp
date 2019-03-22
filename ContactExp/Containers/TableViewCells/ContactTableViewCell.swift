//
//  ContactTableViewCell.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
  
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
  
    func update(withContact contact: ContactsModel) {
        favoriteImageView.isHidden = !contact.favorite
        userNameLabel.text = contact.fullName
    }
    
}
