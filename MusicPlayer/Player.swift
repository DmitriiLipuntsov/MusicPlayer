//
//  Player.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 26.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation
import AVKit

class Player {
    
    static var shared = Player()
    
    var avPlayer: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var currentDuration: Double?
    
    func playTrack(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        if avPlayer.currentItem != playerItem {
        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayer.play()
        }
    }
    

    
}
