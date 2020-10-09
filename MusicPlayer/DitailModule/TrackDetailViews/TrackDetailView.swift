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
    lazy var allStackView = makeAllStackView()
    lazy var timeStackView = makeTimeStackView()
    lazy var timeLabelStackView = makeTimeLabelStackView()
    lazy var nameLabelStackView = makeNameLabelStackView()
    lazy var trackControlView =  makeTrackControlView()
    lazy var volumeStackView = makeVolumeStackView()
    
    var trackImageView = UIImageView()
    var currentTimeSlider = UISlider()
    
    var currentTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.5637609363, green: 0.5688328743, blue: 0.5901173949, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "00:00"
        
        return label
    }()
    
    var durationLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.5637609363, green: 0.5688328743, blue: 0.5901173949, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "--:--"
        
        return label
    }()
    
    var trackNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    var artistNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9889323115, green: 0.1831878126, blue: 0.3349292278, alpha: 1)
        
        return label
    }()
    
    var minVolumeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "IconMin"), for: .normal)
        return button
    }()
    
    var maxVolumeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "IconMax"), for: .normal)
        return button
    }()
    
    var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1
        return slider
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addStacksView()
        setConstrintForSliders()
        
    }
    
    func addStacksView() {
        allStackView.addArrangedSubview(trackImageView)
        allStackView.addArrangedSubview(timeStackView)
        allStackView.addArrangedSubview(nameLabelStackView)
        allStackView.addArrangedSubview(trackControlView)
        allStackView.addArrangedSubview(volumeStackView)
        
        timeStackView.addArrangedSubview(currentTimeSlider)
        timeStackView.addArrangedSubview(timeLabelStackView)
        
        timeLabelStackView.addArrangedSubview(currentTimeLabel)
        timeLabelStackView.addArrangedSubview(durationLabel)
        
        nameLabelStackView.addArrangedSubview(trackNameLabel)
        nameLabelStackView.addArrangedSubview(artistNameLabel)
        
        volumeStackView.addArrangedSubview(minVolumeButton)
        volumeStackView.addArrangedSubview(volumeSlider)
        volumeStackView.addArrangedSubview(maxVolumeButton)
    }
    
    func setConstrintForSliders() {
        allStackView.heightAnchor.constraint(equalToConstant: bounds.height * 0.85).isActive = true
        
        timeStackView.addConstraint(NSLayoutConstraint(item: currentTimeSlider, attribute: .left, relatedBy: .equal, toItem: timeStackView, attribute: .left, multiplier: 1, constant: 0))
        timeStackView.addConstraint(NSLayoutConstraint(item: currentTimeSlider, attribute: .right, relatedBy: .equal, toItem: timeStackView, attribute: .right, multiplier: 1, constant: 0))
        
        volumeStackView.addConstraint(NSLayoutConstraint(item: volumeSlider, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: bounds.width * 0.8))
        
        trackImageView.heightAnchor.constraint(equalToConstant: bounds.height * 0.35).isActive = true
    }
}
