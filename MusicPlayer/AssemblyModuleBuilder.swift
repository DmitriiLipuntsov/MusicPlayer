//
//  AssemblyModuleBuilder.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 22.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func creatMainModule(router: RouterProtocol) -> UIViewController
    func creatDetailModule(router: RouterProtocol, track: TrackModel.Track?) -> UIViewController
    func creatLibraryModule(router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func creatMainModule(router: RouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let networkService = NetworkService()
        let coreDataService = CoreDataStorage()
        let presenter = SearchPresenter(view: view, router: router, networkService: networkService, coreDataService: coreDataService)
        view.presenter = presenter
        return view
    }
    
    func creatDetailModule(router: RouterProtocol, track: TrackModel.Track?) -> UIViewController {
        let view = TrackDetailViewController()
        let networkService = NetworkService()
        let presenter = TrackDetailPresenter(view: view, networkService: networkService, router: router, track: track)
        view.presenter = presenter
        
        return view
    }
    
    func creatLibraryModule(router: RouterProtocol) -> UIViewController {
        let view = LibraryViewController()
        let coreDataService = CoreDataStorage()
        let presenter = LibraryPresenter(view: view, router: router, coreDataService: coreDataService)
        view.presenter = presenter
        
        return view
    }
    
}
