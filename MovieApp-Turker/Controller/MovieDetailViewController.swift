//
//  MovieDetailViewController.swift
//  MovieApp-Turker
//
//  Created by Gülşah Alan on 23.09.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet private weak var backDropImage: UIImageView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var overViewText: UITextView!
    
    var castArray: [Cast]?
    var selectedMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getMovieDetail()
        configureOutlets()
        
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

//MARK: -  Get Movie Details
extension MovieDetailViewController {
    func getMovieDetail() {
            NetworkManager().fetchCastMovie(movieID: self.selectedMovie.id ?? 550) { [weak self] castResponse in
                guard let self = self else { return }
                self.castArray = castResponse
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
       
    }

//MARK: - Configure Outlets
extension MovieDetailViewController {
    func configureOutlets() {
        backDropImage.fetchImage(from: "https://image.tmdb.org/t/p/original\(selectedMovie.backDrop ?? "")")
        rateLabel.text = String(format: "%.1f", selectedMovie.rate ?? 0.0)
        titleLabel.text = selectedMovie.title
        overViewText.text = selectedMovie.overview
    }
}


//MARK: - CollectionView Delegate & Datasource Methods & FlowLayout Methods
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionCell.rawValue, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell()}
        if let castArray = castArray {
            cell.configureCastOutlets(on: castArray[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
}
