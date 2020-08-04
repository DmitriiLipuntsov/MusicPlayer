//
//  TrackModel.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 22.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation

struct TrackModel {
    
    struct Track {
        var trackName: String
        var collectionName: String?
        var artistName: String
        var iconUrlString: String?
        var previewUrl: String?
        var isKept = false
    }
    
    let tracks: [Track]
    
}
