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
        searchBar(UISearchController().searchBar, textDidChange: "Red")
    }
    
    func setup() {
        let nib = UINib(nibName: "TrackViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TrackCell")
        navigationItem.title = "Search"
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
        return presenter.tracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackViewCell
        guard let cellViewModel = presenter.tracks?[indexPath.row] else { return TrackViewCell()}
        cell.set(viewModel: cellViewModel)
        cell.presenter = presenter
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = presenter.tracks?[indexPath.row]
        presenter.tapOnTheTrack(track: track)
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


// MARK: - Delegat
extension SearchViewController {
    
    func getTrack(isNextTrack: Bool) -> TrackModel.Track? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        tableView.deselectRow(at: indexPath, animated: true)
        var nextIndexPath: IndexPath!
        if isNextTrack {
            nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if nextIndexPath.row == presenter.tracks?.count {
                nextIndexPath.row = 0
            }
        } else {
            nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if nextIndexPath.row == -1 {
                nextIndexPath.row = (presenter.tracks?.count ?? 0) - 1
            }
        }
        
        tableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
        let cellViewModel = presenter.tracks?[nextIndexPath.row]
        return cellViewModel
    }
}

