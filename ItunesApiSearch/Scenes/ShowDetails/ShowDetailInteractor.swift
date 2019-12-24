//
//  ShowDetailInteractor.swift
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

protocol ShowDetailBusinessLogic
{
  func getDetails(request: ShowDetail.GetDetails.Request)
}

protocol ShowDetailDataStore
{
   var song: Song! { get set }
}

class ShowDetailInteractor: ShowDetailBusinessLogic, ShowDetailDataStore
{
  var presenter: ShowDetailPresentationLogic?
  var worker: ShowDetailWorker?
  var song: Song!
  
  // MARK: Do something
  
  func getDetails(request: ShowDetail.GetDetails.Request)
  {
    worker = ShowDetailWorker()
    worker?.obtenerCancionesAlmbum()
   
    
    let response = ShowDetail.GetDetails.Response(song: song)
    presenter?.presentDetails(response: response)
     
  }
}