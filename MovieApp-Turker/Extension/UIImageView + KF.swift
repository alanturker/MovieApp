//
//  UIImageView + KF.swift
//  MovieApp-Turker
//
//  Created by Erol on 22.09.2021.
//

import Foundation
import Kingfisher

extension UIImageView {
    func fetchImage(from urlString: String) {
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url)
        }
    }
}

