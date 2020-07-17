//
//  Presenter.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 11.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation
import AVKit

protocol SearchResponseViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol SearchResponseViewPresenterProtocol: class {
    init(view: SearchResponseViewProtocol,
         networkService: NetworkServiceProtocol,
         router: RouterProtocol)
    var tracks: [TrackModel.Cell]? { get }
    func getTracks(searchText: String)
    func playTrack(previewUrl: String?)
    func tapOnTheTrack(track: TrackModel.Cell?)
}

class SearchPresenter: SearchResponseViewPresenterProtocol {
    
    weak var view: SearchResponseViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var tracks: [TrackModel.Cell]?
    var player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    required init(view: SearchResponseViewProtocol,
                  networkService: NetworkServiceProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getTracks(searchText: String) {
        networkService.featchTracks(searchText: searchText) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case.success(let tracks):
                    let cells = tracks.results.map { track in
                        self.trackModel(track: track)
                    }
                    self.tracks = cells
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func playTrack(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
    }
    
    func trackModel(track: Track) -> TrackModel.Cell {
        return TrackModel.Cell.init(trackName: track.trackName,
                                    collectionName: track.collectionName,
                                    artistName: track.artistName,
                                    iconUrlString: track.artworkUrl100,
                                    previewUrl: track.previewUrl)
    }
    
    func tapOnTheTrack(track: TrackModel.Cell?) {
        router?.showDetail(track: track)
    }
}