//
//  TrackControlView.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 25.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

class TrackControlView: UIView {
    
    lazy var previousTrackButton = makePreviousTrackButton()
    lazy var playPauseButton = makePlayPouseButton()
    lazy var nextTrackButton = makeNextTrackButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previousTrackButton.setImage(#imageLiteral(resourceName: "Left"), for: .normal)
        playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        nextTrackButton.setImage(#imageLiteral(resourceName: "Right"), for: .normal)
    }
    
    func makePreviousTrackButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        
        return button
    }
    
    func makePlayPouseButton() -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        button.leftAnchor.constraint(equalTo: previousTrackButton.rightAnchor, constant: 0).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        
        return button
    }
    
    func makeNextTrackButton() -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        button.leftAnchor.constraint(equalTo: playPauseButton.rightAnchor, constant: 0).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        
        return button
    }
    
}

