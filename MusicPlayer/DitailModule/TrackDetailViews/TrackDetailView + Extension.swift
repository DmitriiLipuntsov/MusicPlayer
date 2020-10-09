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
        
        button.setImage(UIImage(named: "DragDown"), for: .normal)
        
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        return button
    }
    
    func makeAllStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: dragDownButton.bottomAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            ])
        
        return stackView
    }
    
    func makeTimeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        
        return stackView
    }
    
    func makeTimeLabelStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
            ])
        
        return stackView
    }
    
    func makeNameLabelStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        
        return stackView
    }
    
    func makeTrackControlView() -> TrackControlView {
        let view = TrackControlView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 200),
            view.heightAnchor.constraint(equalToConstant: 100),
            ])
        return view
    }
    
    func makeVolumeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }
    
}
