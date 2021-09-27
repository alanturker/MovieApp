//
//  MovieTableViewCell.swift
//  MovieApp-Turker
//
//  Created by Erol on 22.09.2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieOverview.bounces = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellOutlets(on model: Movie) {
        movieImage.fetchImage(from: "https://image.tmdb.org/t/p/original\(model.posterPath ?? "")")
        movieTitle.text = model.title ?? ""
        movieOverview.text = model.overview ?? ""
    }
}
