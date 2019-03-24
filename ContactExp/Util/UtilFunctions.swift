//
//  UtilFunctions.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation
import UIKit

struct UtilFunctions {
  static func gradientLayerSetup(on view: UIView) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.frame
    gradientLayer.colors = [UIColor.white.cgColor, Constants.colorClearTurqois.cgColor]
    view.layer.sublayers?.removeAll()
    view.layer.addSublayer(gradientLayer)
  }
  
  static func roundClipping(on view: UIView) {
    view.layer.cornerRadius = view.frame.height / 2
    view.clipsToBounds = true
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
