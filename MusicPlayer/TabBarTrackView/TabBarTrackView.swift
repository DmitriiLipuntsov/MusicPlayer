//
//  TabBarTrackView.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 18.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

class TabBarTrackView: UIView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .green
        return stackView
    }()
    
    let stackViewLabel: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.backgroundColor = .green
        return stackView
    }()
    
    var trackImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.image = #imageLiteral(resourceName: "library")
        
        return image
    }()
    
    var trackNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Not executed"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "artistNameLabel"
        label.textColor = #colorLiteral(red: 0.9889323115, green: 0.1831878126, blue: 0.3349292278, alpha: 1)
        label.isHidden = true
        
        return label
    }()
    
    var trackControlView: TrackControlView = {
        let view = TrackControlView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        setStackView()
        
    }
    
    func setStackView() {
        
        addSubview(stackView)
        
        addItemsToStackView()
        addItemsToStackViewLabel()
        setStackViewConstraints()
    }
    
    func addItemsToStackView() {
        
        stackView.addArrangedSubview(trackImageView)
        stackView.addArrangedSubview(stackViewLabel)
        stackView.addArrangedSubview(trackControlView)
        
    }
    
    func addItemsToStackViewLabel() {
        
        stackViewLabel.addArrangedSubview(trackNameLabel)
        stackViewLabel.addArrangedSubview(artistNameLabel)
    }
    
    func setStackViewConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -10).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
    }
    
}
