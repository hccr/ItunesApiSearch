//
//  ShowDetailViewController.swift
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
import AVFoundation
import AVKit

protocol ShowDetailDisplayLogic: class
{
    func displayDetails(viewModel: ShowDetail.GetDetails.ViewModel)
    func displaySongList(viewModel: ShowDetail.GetSongList.ViewModel)
}

class ShowDetailViewController: UIViewController, ShowDetailDisplayLogic, UITableViewDataSource, UITableViewDelegate{
    var interactor: ShowDetailBusinessLogic?
    var router: (NSObjectProtocol & ShowDetailRoutingLogic & ShowDetailDataPassing)?
    var previewUrl: String?
    var artWorkUrl:String?
    
    var albumSongs:[Song] = []
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ShowDetailInteractor()
        let presenter = ShowDetailPresenter()
        let router = ShowDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getDetails()
    }
    
    var player:AVPlayer?
    
    // MARK: Do something
    
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var nombreCancion: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func playPreview(_ sender: Any) {
        
        let url = NSURL(string: previewUrl!)
        
        
        let playerItem = AVPlayerItem(url: url! as URL)
        
        let player =  AVPlayer(playerItem:playerItem)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController,animated: true){
            playerViewController.player!.play()
        }
        
    }
    
    
    func getDetails()
    {
        let request = ShowDetail.GetDetails.Request()
        interactor?.getDetails(request: request)
        
        
        let requestSongList = ShowDetail.GetSongList.Request()
        interactor?.getSongList(request: requestSongList)
    }
    
    func displayDetails(viewModel: ShowDetail.GetDetails.ViewModel)
    {
        //nameTextField.text = viewModel.name
        albumName.text = viewModel.album
        bandName.text = viewModel.banda
        nombreCancion.text = viewModel.nombreCancion
        previewUrl = viewModel.previewUrl
        artWorkUrl = viewModel.artWorkUrl
        self.imageView.image = getImage()
        
        
    }
    func displaySongList(viewModel: ShowDetail.GetSongList.ViewModel ){
        
        self.albumSongs = viewModel.songs
        self.tableView.reloadData()
        
    }
    
    private func getImage()->UIImage?{
        if let url = URL(string: artWorkUrl!){
            do{
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            }catch let err{
                print("Error: \(err.localizedDescription)")
            }
        }
        return nil
    }
    
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return albumSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let result = albumSongs[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songListCell") as? SongListTableViewCell else {
            return UITableViewCell();
        }
        cell.songName.text = result.trackName
        return cell
    }
}
