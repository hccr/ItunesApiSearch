//
//  SongMO+CoreDataClass.swift
//  ItunesApiSearch
//
//  Created by Harold Campuzano Rivera on 26/12/19.
//  Copyright © 2019 harold-campuzano. All rights reserved.
//
//

import Foundation
import CoreData


public class SongMO: NSManagedObject {
    
    
    
    
    
    
    
    
    func getSong()->Song{
        let song = Song(
            artistId: Int(self.artistId),
            artistName: self.artistName!,
            collectionId: Int(self.collectionId),
            collectionName: self.collectionName!,
            trackId: Int(self.trackId),
            trackName: self.trackName!,
            collectionViewUrl: self.collectionViewUrl!,
            trackViewUrl: self.trackViewUrl!,
            previewUrl: self.previewUrl!,
            artworkUrl60: self.artworkUrl60!,
            artworkUrl100: self.artworkUrl100!
        )
        
        return song
    }

}
