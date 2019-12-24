//
//  ShowDetailModels.swift
//  ItunesApiSearch
//
//  Created by Harold Campuzano Rivera on 24/12/19.
//  Copyright (c) 2019 harold-campuzano. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ShowDetail
{
  // MARK: Use cases
  
  enum GetDetails
  {
    struct Request
    {
    }
    struct Response
    {
        var song: Song
    }
    struct ViewModel
    {
        var album:String
        var banda:String
        var urlImage:String
        var nombreCancion:String
        var previewUrl:String
        var artWorkUrl:String
    }
  }
}
