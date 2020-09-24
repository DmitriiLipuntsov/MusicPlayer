//
//  TrackDetailPresenter.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation

protocol TrackDetailViewProtocol: class {
    func setTrack(track: TrackModel.Track?)
}

protocol TrackDetailPresenterProtocol {
    init(view: TrackDetailViewProtocol,
         router: RouterProtocol,
         tracks: [TrackModel.Track],
         index: Int
    )
    var tracks: [TrackModel.Track] { get }
    var index: Int { get }
    func setTrack()
    func popToRoot()
    func nextTrack(isNextTrack: Bool)
}

class TrackDetailPresenter: TrackDetailPresenterProtocol {
    
    weak var view: TrackDetailViewProtocol?
    var tracks: [TrackModel.Track]
    var index: Int
    var router: RouterProtocol?
    
    
    required init(view: TrackDetailViewProtocol,
                  router: RouterProtocol,
                  tracks: [TrackModel.Track],
                  index: Int
    ) {
        self.view = view
        self.tracks = tracks
        self.router = router
        self.index = index
        setTrack()
    }
    
    func popToRoot() {
        router?.popToRoot(tracks: tracks, index: index)
        
    }
    
    public func setTrack() {
        let track = tracks[index]
        view?.setTrack(track: track)
    }
    
    func nextTrack(isNextTrack: Bool) {
                if isNextTrack {
                index += 1
                if tracks.count - 1 < index {
                    index = 0
                }
            } else {
                index -= 1
                if index == -1 {
                    index = tracks.count - 1
                }
            }
            
            view?.setTrack(track: tracks[index])
        }
    }

