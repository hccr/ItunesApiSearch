//
//  Result.swift
//  ItunesApiSearch
//
//  Created by Harold Campuzano Rivera on 23/12/19.
//  Copyright © 2019 harold-campuzano. All rights reserved.
//

import Foundation
struct FetchResults:Codable {
    var resultCount:Int
    var results:[Result]
}
struct Result: Codable{
    var wrapperType:String
    var kind:String?
    var artistId:Int
    var collectionId:Int
    var trackId:Int?
    var artistName:String
    var collectionName:String
    var trackName:String?
    var collectionCensoredName:String
    var trackCensoredName:String
    var artistViewUrl:String
    var collectionViewUrl:String
    var trackViewUrl:String
    var previewUrl:String
    var artworkUrl60:String?
    var artworkUrl100:String?
    var collectionPrice:Double
    var trackPrice:Double
    var collectionExplicitness:String
    var trackExplicitness:String
    var discCount:Int
    var discNumber:Int
    var trackCount:Int
    var trackNumber:Int
    var trackTimeMillis:Int?
    var country:String
    var currency:String
    var primaryGenreName:String
}


