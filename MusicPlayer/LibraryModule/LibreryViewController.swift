//
//  LibreryViewController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 02.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

class LibreryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        
    }
    
    func setup() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TrackViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TrackCell")
        
    }
    
    func navcreat() {
        
    }

}


//MARK: - UITableViewDelegate
extension LibreryViewController: UITableViewDelegate {
    
}


//MARK: - UITableViewDataSource
extension LibreryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackViewCell
        cell.saveTrackButton.isHidden = true
        return cell
    }
}
