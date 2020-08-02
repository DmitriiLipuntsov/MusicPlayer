//
//  AssemblyModuleBuilder.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 22.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit
import AVKit

protocol AssemblyBuilderProtocol {
    func creatMainModule(router: RouterProtocol) -> UIViewController
    func creatDetailModule(router: RouterProtocol, track: TrackModel.Cell?, player: AVPlayer) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func creatMainModule(router: RouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let networkService = NetworkService()
        let presenter = SearchPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func creatDetailModule(router: RouterProtocol, track: TrackModel.Cell?, player: AVPlayer) -> UIViewController {
        let view = TrackDetailViewController()
        let networkService = NetworkService()
        let presenter = TrackDetailPresenter(view: view, networkService: networkService, router: router, track: track, player: player)
        view.presenter = presenter
        
        return view
    }
    
}
