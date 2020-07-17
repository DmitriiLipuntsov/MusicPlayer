//
//  TrackDetailViewController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

class TrackDetailViewController: UIViewController {
    
    var presenter: TrackDetailPresenterProtocol?
    private var trackDetailView = TrackDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadAllView()
        
        
    }
    
    func loadAllView() {
        view.addSubview(trackDetailView)
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        trackDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
    }
    

}

extension TrackDetailViewController: TrackDetailViewProtocol {
    func setTrack(track: TrackModel.Cell?) {
        trackDetailView.artistNameLabel.text = track?.artistName
        let string600 = track?.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600") //track?.artworkUrl100?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        trackDetailView.trackImageView.sd_setImage(with: url)
        
    }
}
