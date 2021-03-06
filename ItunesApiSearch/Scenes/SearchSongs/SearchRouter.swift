//
//  SearchRouter.swift
//  ItunesApiSearch
//
//  Created by Harold Campuzano Rivera on 23/12/19.
//  Copyright (c) 2019 harold-campuzano. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol SearchRoutingLogic{
    func routeToShowDetail(segue: UIStoryboardSegue?)
}

protocol SearchDataPassing{
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing
{
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
    
    // MARK: Routing
    
    func routeToShowDetail(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowDetail(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "ShowDetailViewController") as! ShowDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowDetail(source: dataStore!, destination: &destinationDS)
            navigateToShowDetail(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Navigation
    
    func navigateToShowDetail(source: SearchViewController, destination: ShowDetailViewController){
        source.show(destination, sender: nil)
    }
    
    
    // MARK: Passing data
    
    
    func passDataToShowDetail(source: SearchDataStore, destination: inout ShowDetailDataStore)    {
        destination.song = viewController?.selectedSong!
    }
}
