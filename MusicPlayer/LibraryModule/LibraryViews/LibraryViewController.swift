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
    
    func setup() {
        
        let nib = UINib(nibName: "TrackViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TrackCell")
        navigationItem.title = "Library"
        
    }

}


//MARK: - UITableViewDelegate
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = presenter?.tracks[indexPath.row]
        presenter?.tapOnTheTrack(track: track)
    }
}


//MARK: - UITableViewDataSource
extension LibraryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tracks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackViewCell
        cell.saveTrackButton.isHidden = true
        guard let track = presenter?.tracks[indexPath.row] else { return UITableViewCell()}
        cell.set(viewModel: track)
        return cell
    }
}

extension LibraryViewController: LibraryViewProtocol {
    
}
