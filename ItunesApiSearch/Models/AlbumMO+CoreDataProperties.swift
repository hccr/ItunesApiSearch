//
//  AlbumMO+CoreDataProperties.swift
//  ItunesApiSearch
//
//  Created by Harold Campuzano Rivera on 26/12/19.
//  Copyright © 2019 harold-campuzano. All rights reserved.
//
//

import Foundation
import CoreData


extension AlbumMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumMO> {
        return NSFetchRequest<AlbumMO>(entityName: "Album")
    }

    @NSManaged public var artistId: Int32
    @NSManaged public var artistName: String?
    @NSManaged public var collectionId: Int32
    @NSManaged public var collectionName: String?
    @NSManaged public var artworkUrl60: String?
    @NSManaged public var artworkUrl100: String?

}
