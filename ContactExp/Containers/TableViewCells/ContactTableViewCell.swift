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
      setupUserImage()
    }
  
    private func setupUserImage() {
      userImageView.layer.cornerRadius = userImageView.frame.height / 2
      userImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
  
    func update(withContact contact: ContactItemListModel) {
        favoriteImageView.isHidden = !contact.favorite
        userNameLabel.text = contact.fullName
        userImageView.image(from: contact.profilePic)
    }
}

extension UIImageView {
  func image(from urlString: String) {
    print("Download Started")
    guard let url = URL(string: urlString) else {
      return
    }
    getData(from: url) {[weak self] data, response, error in
      guard let `self` = self else {
        return
      }
      guard let data = data, error == nil else { return }
      print(response?.suggestedFilename ?? url.lastPathComponent)
      print("Download Finished")
      DispatchQueue.main.async() {
        self.image = UIImage(data: data)
      }
    }
  }
  
  func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }
}
