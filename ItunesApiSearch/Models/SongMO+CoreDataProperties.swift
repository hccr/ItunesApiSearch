//
//  SongMO+CoreDataProperties.swift
//  ItunesApiSearch
//
//  Created by Harold Campuzano Rivera on 26/12/19.
//  Copyright © 2019 harold-campuzano. All rights reserved.
//
//

import Foundation
import CoreData


extension SongMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SongMO> {
        return NSFetchRequest<SongMO>(entityName: "Song")
    }

    @NSManaged public var artistId: Int32
    @NSManaged public var artistName: String?
    @NSManaged public var collectionId: Int32
    @NSManaged public var collectionName: String?
    @NSManaged public var trackId: Int32
    @NSManaged public var trackName: String?
    @NSManaged public var collectionViewUrl: String?
    @NSManaged public var trackViewUrl: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var artworkUrl60: String?
    @NSManaged public var artworkUrl100: String?

}
