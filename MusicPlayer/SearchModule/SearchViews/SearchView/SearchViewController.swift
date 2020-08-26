//
//  SearchViewController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 11.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SearchResponseViewPresenterProtocol!
    private var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSearchBar()
        searchBar(UISearchController().searchBar, textDidChange: "Billie")
    }
    
    func setup() {
        let nib = UINib(nibName: "TrackViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TrackCell")
        navigationItem.title = "Search"
        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.tabBarItem.image = UIImage(named: "search")
//        navigationController?.tabBarItem.title = "Search"
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
}


//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.foundTracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackViewCell
        guard let cellViewModel = presenter.foundTracks?[indexPath.row] else { return TrackViewCell()}
        cell.presenter = presenter
        cell.set(viewModel: cellViewModel)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tracks = presenter.foundTracks else { return }
        presenter.tapOnTheTrack(tracks: tracks, index: indexPath.row)
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.presenter.getTracks(searchText: searchText)
        })
    }
}


//MARK: - SearchResponseViewProtocol

extension SearchViewController: SearchResponseViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print("Error received requesting data: \(error.localizedDescription)")
    }
}




