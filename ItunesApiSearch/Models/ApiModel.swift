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
    var artistId:Int
    var collectionId:Int?
    var trackId:Int?
    var artistName:String
    var collectionName:String
    var trackName:String?
    var collectionViewUrl:String
    var trackViewUrl:String
    var previewUrl:String
    var artworkUrl60:String?
    var artworkUrl100:String?
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


