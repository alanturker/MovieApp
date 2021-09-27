//
//  SearchMoviesViewController.swift
//  MovieApp-Turker
//
//  Created by Erol on 22.09.2021.
//

import UIKit

enum MovieState {
    case found
    case notfound
}

class SearchMoviesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var loadingScreen: UIView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var couldntFindView: UIView!
    @IBOutlet private weak var couldntFindImage: UIImageView!
    @IBOutlet private weak var couldntFindLabel: UILabel!
    
    var movies: [Movie]?
    
    var movieState: MovieState? {
        didSet {
            if movieState == .found {
                couldntFindView.isHidden = true
                couldntFindImage.isHidden = true
                couldntFindLabel.isHidden = true
            } else {
                couldntFindLabel.isHidden = false
                couldntFindImage.isHidden = false
                couldntFindImage.image = #imageLiteral(resourceName: "myBad")
                couldntFindView.isHidden = false
            }
        }
    }
    
    var screenState: ScreenState? {
        didSet {
            if screenState == .loaded {
                loadingScreen.isHidden = true
                loadingIndicator.stopAnimating()
                tableView.isHidden = false
                loadingIndicator.hidesWhenStopped = true
            } else {
                loadingScreen.isHidden = false
                loadingIndicator.startAnimating()
                tableView.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutletDelegates()
        screenState = .loaded
        movieState = .found
        title = "Top Rated Movies"
        getTopRatedMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTopRatedMovies()
    }
    
    private func configureOutletDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.bounces = false
    }
}

//MARK: - UISearchBar Delegate
extension SearchMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.screenState = .loaded
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                self.screenState = .loaded
                self.movies = []
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
                self.movieState = .found
                self.getTopRatedMovies()
            }
           
        } else {
            if searchBar.text?.count ?? 0 >= 3 {
                screenState = .loading
            }
            
        }
    }
    
}

//MARK: - Get Top Rated Movies
extension SearchMoviesViewController {
    func getTopRatedMovies() {
        NetworkManager().fetchTopRatedMovies { [weak self] movieResponse in
            guard let self = self else { return }
            self.movies = movieResponse
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - Search Movies Fetch
extension SearchMoviesViewController {
    
    func getSearchMovies() {
        searchBar.resignFirstResponder()
        
        guard let query = searchBar.text, !query.isEmpty else { return }
        NetworkManager().searchMovies(query: query) { [weak self] movieResponse in
            guard let self = self else { return }
            self.movies = movieResponse
            if let movieArray = self.movies {
                if movieArray.isEmpty {
                    self.movieState = .notfound
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
}

//MARK: - UITableView Delegate and Datasource
extension SearchMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cell.rawValue, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
    
            if let movies = self.movies {
                cell.configureCellOutlets(on: movies[indexPath.row])
            }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedMovieSearchVC = movies?[indexPath.row] else { return }
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.detailVC.rawValue) as? MovieDetailViewController else { return }
        detailVC.selectedMovie = selectedMovieSearchVC
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


