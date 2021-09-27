//
//  ViewController.swift
//  MovieApp-Turker
//
//  Created by Erol on 22.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var popularButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var upcomingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view."
        popularButton.layer.cornerRadius = 15
        searchButton.layer.cornerRadius = 15
        upcomingButton.layer.cornerRadius = 15

    }
    
    @IBAction private func popularButtonTapped(_ sender: UIButton) {
        guard let popularVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.popularVC.rawValue) as? PopularMoviesViewController else { return }
        popularVC.upcomingMoviesSelected = false
        navigationController?.pushViewController(popularVC, animated: true)
    }
    
    @IBAction private func searchButtonTapped(_ sender: UIButton) {
        guard let searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.searchVC.rawValue) as? SearchMoviesViewController else { return }
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction private func upcomingButtonTapped(_ sender: UIButton) {
        guard let upcomingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: K.popularVC.rawValue) as? PopularMoviesViewController else { return }
        upcomingVC.upcomingMoviesSelected = true
        navigationController?.pushViewController(upcomingVC, animated: true)
    }
}

