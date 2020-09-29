//
//  LibreryViewController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 02.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LibraryViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup() {
        
        let nib = UINib(nibName: "TrackViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TrackCell")
        navigationItem.title = "Library"
        
    }

}


//MARK: - UITableViewDelegate
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tracks = presenter?.tracks else { return }
        presenter?.tapOnTheTrack(tracks: tracks, index: indexPath.row)
    }
}


//MARK: - UITableViewDataSource
extension LibraryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tracks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackViewCell
        guard let track = presenter?.tracks[indexPath.row] else { return UITableViewCell()}
        cell.set(viewModel: track)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteTrack(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            (tabBarController as! TabBarController).tracks?.remove(at: indexPath.row)
        }
    }
}

//MARK: - LibraryViewProtocol
extension LibraryViewController: LibraryViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
