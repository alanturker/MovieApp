//
//  CastCollectionViewCell.swift
//  MovieApp-Turker
//
//  Created by Gülşah Alan on 23.09.2021.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var castImage: UIImageView!
    @IBOutlet private weak var castName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCastOutlets(on model: Cast) {
        castImage.fetchImage(from: "https://image.tmdb.org/t/p/original\(model.profile ?? "")")
        castName.text = model.name
    }
    
}
