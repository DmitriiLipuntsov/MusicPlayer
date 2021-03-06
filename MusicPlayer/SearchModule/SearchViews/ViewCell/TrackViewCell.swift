//
//  TrackViewCell.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 11.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit
import SDWebImage

class TrackViewCell: UITableViewCell {
    
    @IBOutlet weak var playPauseOutlet: UIButton!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var saveTrackButton: UIButton!
    
    var presenter: SearchResponseViewPresenterProtocol?
    var currentTrack: TrackModel.Track?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func set(viewModel: TrackModel.Track) {
        
        if let savedTracks = presenter?.savedTracks {
            let hasSaved = savedTracks.firstIndex {
                $0.previewUrl == viewModel.previewUrl
                } != nil
            
            if hasSaved {
                saveTrackButton.isHidden = true
            } else {
                saveTrackButton.isHidden = false
            }
        }
        
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
        currentTrack = viewModel
    }
    
    @IBAction func addInLibrary(_ sender: Any) {
        presenter?.addInLibrary(track: currentTrack)
        saveTrackButton.isHidden = true
    }
    
}


