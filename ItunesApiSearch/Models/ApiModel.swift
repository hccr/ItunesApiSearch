//
//  Result.swift
//  ItunesApiSearch
//
//  Created by Harold Campuzano Rivera on 23/12/19.
//  Copyright © 2019 harold-campuzano. All rights reserved.
//

import Foundation
struct FetchSongs:Codable {
    var resultCount:Int
    var results:[Song]
}
struct Song: Codable{
    var artistId:Int?
    var collectionId:Int?
    var trackId:Int?
    var artistName:String?
    var collectionName:String?
    var trackName:String?
    var collectionViewUrl:String?
    var trackViewUrl:String?
    var previewUrl:String?
    var artworkUrl60:String?
    var artworkUrl100:String?
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        
        artistId = dictionary["artistId"] as? Int
        collectionId = dictionary["collectionId"] as? Int
        trackId = dictionary["trackId"] as? Int
        artistName = dictionary["artistName"] as? String
        collectionName = dictionary["collectionName"] as? String
        trackName = dictionary["trackName"] as? String
        collectionViewUrl = dictionary["collectionViewUrl"] as? String
        trackViewUrl = dictionary["trackViewUrl"] as? String
        previewUrl = dictionary["previewUrl"] as? String
        artworkUrl60 = dictionary["artworkUrl60"] as? String
        artworkUrl100 = dictionary["artworkUrl100"] as? String
    }
}
struct Album{
    var artistId:Int
    var artistName:String
    var collectionName:String
    var collectionId:Int?
    var artworkUrl60:String?
    var artworkUrl100:String?
    var songs:[Song]
}


