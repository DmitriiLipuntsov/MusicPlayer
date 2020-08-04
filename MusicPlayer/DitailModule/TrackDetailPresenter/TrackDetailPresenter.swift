//
//  TrackDetailPresenter.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation

protocol TrackDetailViewProtocol: class {
    func setTrack(track: TrackModel.Cell?)
}

protocol TrackDetailPresenterProtocol {
    init(view: TrackDetailViewProtocol,
         networkService: NetworkServiceProtocol,
         router: RouterProtocol,
         track: TrackModel.Cell?
    )
    var track: TrackModel.Cell? { get }
    func setTrack()
    func popToRoot()
    func nextTrack(isNextTrack: Bool)
}

class TrackDetailPresenter: TrackDetailPresenterProtocol {
    
    weak var view: TrackDetailViewProtocol?
    var networkService: NetworkServiceProtocol!
    var track: TrackModel.Cell?
    var router: RouterProtocol?

    
    required init(view: TrackDetailViewProtocol,
         networkService: NetworkServiceProtocol,
         router: RouterProtocol,
         track: TrackModel.Cell?
    ) {
        self.view = view
        self.networkService = networkService
        self.track = track
        self.router = router
    }
    
    func popToRoot() {
        router?.popToRoot()
        
    }
    
    public func setTrack() {
        view?.setTrack(track: track)
    }
    
    func nextTrack(isNextTrack: Bool) {
        router?.setTrack(isNextTrack: isNextTrack) { [weak self] newTrack in
            guard let self = self else { return }
            self.view?.setTrack(track: newTrack)
        }
    }
    
}
