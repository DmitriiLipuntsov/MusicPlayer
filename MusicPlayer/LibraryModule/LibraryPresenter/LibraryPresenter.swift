//
//  LibraryPresenter.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 10.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation

protocol LibraryViewProtocol: class {
    
}

protocol LibraryViewPresenterProtocol: class {
    
    init(view: LibraryViewProtocol,
         router: RouterProtocol,
         coreDataService: CoreDataServiceProtocol)
    
    var tracks: [TrackModel.Track] { get }
    func tapOnTheTrack(track: TrackModel.Track?)
    
}

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
        featchTracks()
    }
    
    func tapOnTheTrack(track: TrackModel.Track?) {
        router?.showDetail(track: track)
    }
    
    func featchTracks() {
        tracks = coreDataService?.getConvertedSavedTracks() ?? []
    }
    
    
    
}
