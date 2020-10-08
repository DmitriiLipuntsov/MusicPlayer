//
//  CoreDataService.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 07.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataServiceDelegate: class {
    func update()
}

protocol CoreDataServiceProtocol {
    var libraryDelegate: CoreDataServiceDelegate? { get set }
    var searchDelegate: CoreDataServiceDelegate? { get set }
    func saveTrack(track: TrackModel.Track?)
    func deleteTrack(index: Int)
    func featchTrack(complition: @escaping (Result<[TrackModel.Track], Error>) -> Void)
}

class CoreDataStorage: CoreDataServiceProtocol {

    private let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentConteiner.viewContext
    
    weak var libraryDelegate: CoreDataServiceDelegate?
    weak var searchDelegate: CoreDataServiceDelegate?
    
    func saveTrack(track: TrackModel.Track?) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SavedTrack", in: manageContext) else { return }
        let savedTrack = NSManagedObject(entity: entity, insertInto: manageContext) as! SavedTrack
        
        savedTrack.artistName = track?.artistName
        savedTrack.collectionName = track?.collectionName
        savedTrack.iconUrlString = track?.iconUrlString
        savedTrack.trackName = track?.trackName
        savedTrack.previewUrl = track?.previewUrl
            
        do {
            try manageContext.save()
            libraryDelegate?.update()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func featchTrack(complition: @escaping (Result<[TrackModel.Track], Error>) -> Void) {
        let featchRequest: NSFetchRequest<SavedTrack> = SavedTrack.fetchRequest()
        do {
            let savedTrack = try manageContext.fetch(featchRequest)
            let tracks = getConvertedSavedTracks(savedTrack: savedTrack)
            complition(.success(tracks))
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTrack(index: Int) {
        let featchRequest: NSFetchRequest<SavedTrack> = SavedTrack.fetchRequest()
        do {
            let savedTracks = try manageContext.fetch(featchRequest)
            manageContext.delete(savedTracks[index])
            try manageContext.save()
            searchDelegate?.update()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func getConvertedSavedTracks(savedTrack: [SavedTrack]) -> [TrackModel.Track] {
        var tracks = [TrackModel.Track]()
        savedTrack.forEach({ track in
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

