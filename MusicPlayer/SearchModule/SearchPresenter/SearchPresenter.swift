//
//  Presenter.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 11.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation

protocol SearchResponseViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol SearchResponseViewPresenterProtocol: class {
    init(view: SearchResponseViewProtocol,
         router: RouterProtocol,
         networkService: NetworkServiceProtocol,
         coreDataService: CoreDataServiceProtocol)
    var foundTracks: [TrackModel.Track]? { get }
    var savedTracks: [TrackModel.Track]? { get }
    func getTracks(searchText: String)
    func tapOnTheTrack(tracks: [TrackModel.Track], index: Int)
    func addInLibrary(track: TrackModel.Track?)
}

class SearchPresenter: SearchResponseViewPresenterProtocol {
    
    weak var view: SearchResponseViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var coreDataService: CoreDataServiceProtocol?
    var foundTracks: [TrackModel.Track]?
    var savedTracks: [TrackModel.Track]?
    
    required init(view: SearchResponseViewProtocol,
                  router: RouterProtocol,
                  networkService: NetworkServiceProtocol,
                  coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.coreDataService?.searchDelegate = self
        getSavedTrack()
    }
    
    func getTracks(searchText: String) {
        networkService.featchTracks(searchText: searchText) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let tracks):
                let cells = tracks.results.map { track in
                    self.trackModel(track: track)
                }
                self.foundTracks = cells
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func tapOnTheTrack(tracks: [TrackModel.Track], index: Int) {
        router?.showDetail(tracks: tracks, index: index)
    }
    
    func addInLibrary(track: TrackModel.Track?) {
        coreDataService?.saveTrack(track: track)
    }
    
    private func trackModel(track: Track) -> TrackModel.Track {
        return TrackModel.Track.init(trackName: track.trackName,
                                    collectionName: track.collectionName,
                                    artistName: track.artistName,
                                    iconUrlString: track.artworkUrl100,
                                    previewUrl: track.previewUrl)
    }
    
    private func getSavedTrack() {
        coreDataService?.featchTrack(complition: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tracks):
                self.savedTracks = tracks
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

//MARK: - CoreDataServiceDelegate
extension SearchPresenter: CoreDataServiceDelegate {
    func update() {
        getSavedTrack()
        view?.success()
    }
}
