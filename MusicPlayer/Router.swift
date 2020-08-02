//
//  Router.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 22.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit
import AVKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(track: TrackModel.Cell?, player: AVPlayer)
    func popToRoot()
    func nextTrack(isForwardTrack: Bool, complition: @escaping (TrackModel.Cell?) -> ())
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.creatMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(track: TrackModel.Cell?, player: AVPlayer) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.creatDetailModule(router: self, track: track, player: player) else { return }
            //navigationController.pushViewController(detailViewController, animated: true)
            navigationController.present(detailViewController, animated: true, completion: nil)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
            
        }
    }
    
    func nextTrack(isForwardTrack: Bool, complition: @escaping (TrackModel.Cell?) -> ()) {
        setPreviousTrack(isForwardTrack: isForwardTrack, complition: complition)
    }
    func setPreviousTrack(isForwardTrack: Bool, complition: @escaping (TrackModel.Cell?) -> Void) {
        
    }
}
