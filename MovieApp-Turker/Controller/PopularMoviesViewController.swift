//
//  PopularMoviesViewController.swift
//  MovieApp-Turker
//
//  Created by Erol on 22.09.2021.
//

import UIKit

enum ScreenState {
    case loaded
    case loading
}

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingScreen: UIView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    var movieArray: [Movie]?
    
    lazy var upcomingMoviesSelected: Bool = false
    
    var screenState: ScreenState? {
        didSet {
            if screenState == .loaded {
                loadingScreen.isHidden = true
                tableView.isHidden = false
                loadingIndicator.stopAnimating()
                loadingIndicator.hidesWhenStopped = true
            } else {
                loadingScreen.isHidden = false
                tableView.isHidden = true
                loadingIndicator.startAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        screenState = .loading
        if upcomingMoviesSelected {
            getUpcomingMovies()
            title = "Upcoming Movies"
        } else {
            getPopularMovies()
            title = "Popular Movies"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if upcomingMoviesSelected {
            getUpcomingMovies()
            title = "Upcoming Movies"
        } else {
            getPopularMovies()
            title = "Popular Movies"
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
    }
}
//MARK: - Popular Movies Fetch
extension PopularMoviesViewController {
    func getPopularMovies() {
        screenState = .loading
        NetworkManager().fetchPopularMovies { [weak self] movieResponse in
            guard let self = self else { return }
            self.movieArray = movieResponse
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.screenState = .loaded
            }
        }
    }
}

//MARK: - Upcoming Movies Fetch
extension PopularMoviesViewController {
    func getUpcomingMovies() {
        screenState = .loading
        NetworkManager().fetchUpcomingMovies { [weak self] movieResponse in
            guard let self = self else { return }
            self.movieArray = movieResponse
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.screenState = .loaded
            }
        }
    }
}

//MARK: - UITableView Delegate and Datasource
extension PopularMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cell.rawValue) as? MovieTableViewCell else { return UITableViewCell() }
        if let movieArray = movieArray {
            cell.configureCellOutlets(on: movieArray[indexPath.row])
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedMoviesPopularVC = movieArray?[indexPath.row] else { return }
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.detailVC.rawValue) as? MovieDetailViewController else { return }
        detailVC.selectedMovie = selectedMoviesPopularVC
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
