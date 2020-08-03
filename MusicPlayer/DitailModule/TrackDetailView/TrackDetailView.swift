//
//  TrackDetailView.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

class TrackDetailView: UIView {
    
    lazy var dragDownButton = makeDragDownButton()
    lazy var trackImageView = makeTrackImageView()
    lazy var currentTimeSlider = makeSliderCurrentTime()
    lazy var currentTimeLabel = makeCurrentTimeLabel()
    lazy var durationLabel = makeDurationLabel()
    lazy var trackNameLabel = makeTrackNameLabel()
    lazy var artistNameLabel = makeArtistNameLabel()
    lazy var trackControlView = makeTrackControlView()
    lazy var minVolumeButton = makeMinVolumeButton()
    lazy var maxVolumeButton = makeMaxVolumeButton()
    lazy var volumeSlider = makeVolumeSlider()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dragDownButton.setImage(#imageLiteral(resourceName: "DragDown"), for: .normal)
        currentTimeSlider.value = 0
        currentTimeLabel.text = "00:00"
        durationLabel.text = "--:--"
        minVolumeButton.setImage(#imageLiteral(resourceName: "IconMin"), for: .normal)
        maxVolumeButton.setImage(#imageLiteral(resourceName: "IconMax"), for: .normal)
        volumeSlider.value = 1
        
    }
    
}
