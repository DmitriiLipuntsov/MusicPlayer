//
//  TrackDetailPresenter.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation
import AVKit

protocol TrackDetailViewProtocol: class {
    func setTrack(track: TrackModel.Cell?, player: AVPlayer?)
}

protocol TrackDetailPresenterProtocol {
    init(view: TrackDetailViewProtocol,
         networkService: NetworkServiceProtocol,
         router: RouterProtocol,
         track: TrackModel.Cell?,
         player: AVPlayer?)
    var track: TrackModel.Cell? { get }
    var player: AVPlayer? { get }
    func setTrack()
    func popToRoot()
}

class TrackDetailPresenter: TrackDetailPresenterProtocol {
    
    weak var view: TrackDetailViewProtocol?
    var networkService: NetworkServiceProtocol!
    var track: TrackModel.Cell?
    var router: RouterProtocol?
    var player: AVPlayer?

    
    required init(view: TrackDetailViewProtocol,
         networkService: NetworkServiceProtocol,
         router: RouterProtocol,
         track: TrackModel.Cell?,
         player: AVPlayer?) {
        self.view = view
        self.networkService = networkService
        self.track = track
        self.router = router
        self.player = player
    }
    
    func popToRoot() {
        router?.popToRoot()
        
    }
    
    public func setTrack() {
        view?.setTrack(track: track, player: player)
    }
    
}
