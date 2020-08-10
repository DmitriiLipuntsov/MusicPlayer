//
//  TrackDetailView + Extension.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

extension TrackDetailView {
    
    func makeDragDownButton() -> UIButton {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        return button
    }
    
    func makeTrackImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        imageView.topAnchor.constraint(equalTo: dragDownButton.bottomAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        
        return imageView
    }
    
    func makeSliderCurrentTime() -> UISlider {
        let slider = UISlider()
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(slider)
        
        slider.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        slider.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
        slider.topAnchor.constraint(equalTo: trackImageView.bottomAnchor, constant: 10).isActive = true
        
        return slider
    }
    
    func makeCurrentTimeLabel() -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -bounds.width / 2).isActive = true
        label.topAnchor.constraint(equalTo: currentTimeSlider.bottomAnchor, constant: 0).isActive = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.5637609363, green: 0.5688328743, blue: 0.5901173949, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }
    
    func makeDurationLabel() -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: bounds.width / 2).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: currentTimeSlider.bottomAnchor, constant: 0).isActive = true
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.5637609363, green: 0.5688328743, blue: 0.5901173949, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }
    
    func makeTrackNameLabel() -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 10).isActive = true
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }
    
    func makeArtistNameLabel() -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 0).isActive = true
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9889323115, green: 0.1831878126, blue: 0.3349292278, alpha: 1)
        
        return label
    }
    
    func makeTrackControlView() -> TrackControlView {
        let view = TrackControlView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 10).isActive = true
        view.heightAnchor.constraint(equalToConstant: 105).isActive = true
        
        return view
    }
    
    func makeMinVolumeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
        button.topAnchor.constraint(equalTo: trackControlView.bottomAnchor, constant: 16).isActive = true
        
        return button
    }
    
    func makeVolumeSlider() -> UISlider {
        let slider = UISlider()
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(slider)
        
        slider.leftAnchor.constraint(equalTo: minVolumeButton.rightAnchor, constant: 10).isActive = true
        slider.rightAnchor.constraint(equalTo: maxVolumeButton.leftAnchor, constant: -10).isActive = true
        slider.topAnchor.constraint(equalTo: trackControlView.bottomAnchor, constant: 10).isActive = true
        
        return slider
    }
    
    func makeMaxVolumeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
        button.topAnchor.constraint(equalTo: minVolumeButton.topAnchor).isActive = true
        
        return button
    }
    
}
