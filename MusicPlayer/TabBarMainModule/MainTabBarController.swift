//
//  MainTabBarController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 02.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

protocol MainTabBarControllerProtocol: class {
    func minimizeTrackDetailController()
    func maximaizeTrackDetailController(viewModel: TrackModel.Cell?)
}


class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController()
    let trackDetailView: TrackDetailViewController = TrackDetailViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        creatModuls()
        trackDetailView.delegate = searchVC
    }
    
    
    func creatModuls() {
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyModuleBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        
        setTabBarItems()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.image = UIImage(named: "search")
        navigationController.tabBarItem.title = "Search"
        
        let libraryVC = LibreryViewController()
        
        setViewControllers([navigationController, generateViewController(rootViewController: libraryVC, image: #imageLiteral(resourceName: "library"), title: "Library")], animated: true)
    }
    
    func setTabBarItems() {
        
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
    

}
