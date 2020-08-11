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
    var tabBarController: UITabBarController? { get set }
    var searchNavigationController: UINavigationController? { get set }
    var libraryNavigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(track: TrackModel.Track?)
    func popToRoot()
    func setTrack(isNextTrack: Bool, complition: @escaping (TrackModel.Track?) -> ())
}

class Router: RouterProtocol {
    
    var tabBarController: UITabBarController?
    var searchNavigationController: UINavigationController?
    var libraryNavigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var searchVC: SearchViewController?
    
    init(tabBarController: UITabBarController,
         searchNavigationController: UINavigationController,
         libraryNavigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.tabBarController = tabBarController
        self.searchNavigationController = searchNavigationController
        self.libraryNavigationController = libraryNavigationController
        self.assemblyBuilder = assemblyBuilder
        setupSearchNavigationController()
        setupLibraryNavigationController()
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.9889323115, green: 0.1831878126, blue: 0.3349292278, alpha: 1)
    }
    
    func setupSearchNavigationController() {
        searchNavigationController?.navigationBar.prefersLargeTitles = true
        searchNavigationController?.tabBarItem.image = UIImage(named: "search")
        searchNavigationController?.tabBarItem.title = "Search"
    }
    
    func setupLibraryNavigationController() {
        libraryNavigationController?.navigationBar.prefersLargeTitles = true
        libraryNavigationController?.tabBarItem.image = UIImage(named: "library")
        libraryNavigationController?.tabBarItem.title = "Library"
    }
    
    func initialViewController() {
        
        if let tabBarController = tabBarController {
            guard let searchNavigationController = searchNavigationController else { return }
            guard let libraryNavigationController = libraryNavigationController else { return }
            guard let mainViewController = assemblyBuilder?.creatMainModule(router: self) else { return }
            guard let libraryVieweController = assemblyBuilder?.creatLibraryModule(router: self) else { return }
            searchNavigationController.viewControllers = [mainViewController]
            libraryNavigationController.viewControllers = [libraryVieweController]
            searchVC = mainViewController as? SearchViewController
            tabBarController.setViewControllers(
                [searchNavigationController, libraryNavigationController],
                animated: true
            )
        }
        
    }
    
    func showDetail(track: TrackModel.Track?) {
        if let navigationController = searchNavigationController {
            guard let detailViewController = assemblyBuilder?.creatDetailModule(router: self, track: track) else { return }
            navigationController.present(detailViewController, animated: true, completion: nil)
        }
    }
    
    func popToRoot() {
        if let navigationController = searchNavigationController {
            navigationController.popToRootViewController(animated: true)
            
        }
    }
    
    func setTrack(isNextTrack: Bool, complition: @escaping (TrackModel.Track?) -> ()) {
        complition(searchVC?.getTrack(isNextTrack: isNextTrack))
    }
    
}
