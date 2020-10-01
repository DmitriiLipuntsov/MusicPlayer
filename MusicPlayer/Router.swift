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
    
    private func setupSearchNavigationController() {
        searchNavigationController?.navigationBar.prefersLargeTitles = true
        searchNavigationController?.tabBarItem.image = UIImage(named: "search")
        searchNavigationController?.tabBarItem.title = "Search"
    }
    
    private func setupLibraryNavigationController() {
        libraryNavigationController?.navigationBar.prefersLargeTitles = true
        libraryNavigationController?.tabBarItem.image = UIImage(named: "library")
        libraryNavigationController?.tabBarItem.title = "Library"
    }
    
    func initialViewController() {
        
        if let tabBarController = tabBarController {
            tabBarController.router = self
            guard let searchNavigationController = searchNavigationController else { return }
            guard let libraryNavigationController = libraryNavigationController else { return }
            guard let searchViewController = assemblyBuilder?.creatMainModule(router: self) else { return }
            guard let libraryViewController = assemblyBuilder?.creatLibraryModule(router: self) else { return }
            searchNavigationController.viewControllers = [searchViewController]
            libraryNavigationController.viewControllers = [libraryViewController]
            tabBarController.setViewControllers(
                [libraryNavigationController, searchNavigationController],
                animated: true
            )
        }
    }
    
    func popToRoot(tracks: [TrackModel.Track], index: Int) {
        tabBarController?.setupTrack(tracks: tracks, index: index)
        tabBarController?.setImageForPlayButton()
        if tabBarController?.selectedViewController == searchNavigationController {
            let searchViewController = searchNavigationController?.topViewController as! SearchViewController
            if searchViewController.presenter.foundTracks == tracks {
                searchViewController.selectedRow = index
            }
        } else if tabBarController?.selectedViewController == libraryNavigationController {
            let libraryViewController = libraryNavigationController?.topViewController as! LibraryViewController
            if libraryViewController.presenter?.tracks == tracks {
                libraryViewController.selectedRow = index
            }
        }
    }
    
    func showDetail(tracks: [TrackModel.Track], index: Int) {
        if let navigationController = searchNavigationController {
            presentDetail(navigationController: navigationController, tracks: tracks, index: index)
        } else if let navigationController = searchNavigationController {
            presentDetail(navigationController: navigationController, tracks: tracks, index: index)
        }
    }
    
    private func presentDetail(navigationController: UINavigationController, tracks: [TrackModel.Track], index: Int) {
        guard let detailViewController = assemblyBuilder?.creatDetailModule(router: self, tracks: tracks, index: index) else { return }
        navigationController.present(detailViewController, animated: true)
    }
    
}
