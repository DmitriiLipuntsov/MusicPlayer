//
//  CoreDataService.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 07.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    var tracks: [SavedTrack] { get }
    func saveTrack(track: TrackModel.Track?)
    func featchTrack()
    func getConvertedSavedTracks() -> [TrackModel.Track]
}

class CoreDataStorage: CoreDataServiceProtocol {
    
    var tracks: [SavedTrack] = []
    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentConteiner.viewContext
    
    init() {
        featchTrack()
    }
    
    func saveTrack(track: TrackModel.Track?) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SavedTrack", in: manageContext) else { return }
        let CDTrack = NSManagedObject(entity: entity, insertInto: manageContext) as! SavedTrack
        
        CDTrack.artistName = track?.artistName
        CDTrack.collectionName = track?.collectionName
        CDTrack.iconUrlString = track?.iconUrlString
        CDTrack.trackName = track?.trackName
        CDTrack.previewUrl = track?.previewUrl
        
            
        do {
            try manageContext.save()
            tracks.append(CDTrack)
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    func featchTrack() {
        let featchRequest: NSFetchRequest<SavedTrack> = SavedTrack.fetchRequest()
        do {
            tracks = try manageContext.fetch(featchRequest)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getConvertedSavedTracks() -> [TrackModel.Track] {
        var tracks = [TrackModel.Track]()
        self.tracks.forEach({ track in
            let finalTrack = TrackModel.Track(
                trackName: track.trackName ?? "",
                collectionName: track.collectionName,
                artistName: track.artistName ?? "",
                iconUrlString: track.iconUrlString,
                previewUrl: track.previewUrl)
            tracks.append(finalTrack)
        })
        return tracks
    }
}
