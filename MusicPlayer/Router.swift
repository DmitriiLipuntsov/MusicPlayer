//
//  Router.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 22.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

protocol RouterMain {
    var tabBarController: TabBarController? { get set }
    var searchNavigationController: UINavigationController? { get set }
    var libraryNavigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(tracks: [TrackModel.Track], index: Int)
    func popToRoot(tracks: [TrackModel.Track], index: Int)
}

class Router: RouterProtocol {

    var tabBarController: TabBarController?
    var searchNavigationController: UINavigationController?
    var libraryNavigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var searchVC: SearchViewController?
    
    init(tabBarController: TabBarController,
         searchNavigationController: UINavigationController,
         libraryNavigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.tabBarController = tabBarController
        self.searchNavigationController = searchNavigationController
        self.libraryNavigationController = libraryNavigationController
        self.assemblyBuilder = assemblyBuilder
        setupSearchNavigationController()
        setupLibraryNavigationController()
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
            tabBarController.setViewControllers(
                [searchNavigationController, libraryNavigationController],
                animated: true
            )
        }
        
    }
    
    func showDetail(tracks: [TrackModel.Track], index: Int) {
        if let navigationController = searchNavigationController {
            guard let detailViewController = assemblyBuilder?.creatDetailModule(router: self, tracks: tracks, index: index) else { return }
            navigationController.present(detailViewController, animated: true)
        }
    }
    
    func popToRoot(tracks: [TrackModel.Track], index: Int) {
//        if let navigationController = searchNavigationController {
//            navigationController.popToRootViewController(animated: true)
//
//        }
        tabBarController?.tracks = tracks
        tabBarController?.index = index
        tabBarController?.setupTrack()
    }
    
}
