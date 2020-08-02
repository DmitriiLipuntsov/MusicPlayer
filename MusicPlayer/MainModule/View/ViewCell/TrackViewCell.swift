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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    deinit {
        playPauseOutlet.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        print("deinit-------")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func set(viewModel: TrackModel.Cell) {
        
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
        
    }
    
}
