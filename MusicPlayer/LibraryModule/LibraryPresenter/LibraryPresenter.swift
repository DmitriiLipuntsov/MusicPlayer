//
//  LibraryPresenter.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 10.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation

//MARK: - Protocol
protocol LibraryViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol LibraryViewPresenterProtocol: class {
    
    init(view: LibraryViewProtocol,
         router: RouterProtocol,
         coreDataService: CoreDataServiceProtocol)
    
    var tracks: [TrackModel.Track] { get }
    func tapOnTheTrack(tracks: [TrackModel.Track], index: Int)
    
}

//MARK: - Class
class LibraryPresenter: LibraryViewPresenterProtocol {
    
    var view: LibraryViewProtocol?
    var router: RouterProtocol?
    var coreDataService: CoreDataServiceProtocol?
    var tracks: [TrackModel.Track] = []
    
    required init(view: LibraryViewProtocol,
                  router: RouterProtocol,
                  coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.router = router
        self.coreDataService = coreDataService
        self.coreDataService?.delegate = self
        featchTracks()
    }
    
    func tapOnTheTrack(tracks: [TrackModel.Track], index: Int) {
        router?.showDetail(tracks: tracks, index: index)
    }
    
    func featchTracks() {
        coreDataService?.featchTrack(complition: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let tracks):
                    self.tracks = tracks
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
}

//MARK: - CoreDataServiceDelegate
extension LibraryPresenter: CoreDataServiceDelegate {
    func update() {
        featchTracks()
        view?.success()
    }
}
