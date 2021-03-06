//
//  SearchViewController.swift
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

protocol SearchDisplayLogic: class
{
    func displayResults(viewModel: Search.FetchResults.ViewModel)
}

class SearchViewController: UIViewController, SearchDisplayLogic, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    var busquedasAnteriores: [Song] = []
    var displayedSongs: [Song] = []
    var searchedText = "";
    var selectedSong:Song?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
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
                
                //Antes de pasar a la proxima vista guardo la info
                let selectedRow = tableView.indexPathForSelectedRow?.row
                
                
                
                //Detecta cuando el evento viene desde una busqueda anterior (memoria) o desde una busqueda reciente
                if(selectedRow! > displayedSongs.count ){
                    //Se ajusta el indice para que contabilice las dos filas anteriores
                    //(Mensaje de texto no encontrado y celda titulo "Busquedas anteriores")
                    // Y tambien se resta el largo de las canciones ya desplegadas, por ejemplo realiza una
                    // busqueda pero aun asi presiona una cancion de una busqueda anterior
                    
                    selectedSong = busquedasAnteriores[selectedRow! - 2 - displayedSongs.count]
                }else{
                    selectedSong = displayedSongs[selectedRow!]
                }
                
                guard let selectedSong = selectedSong else {
                    return
                }
                
                
                let songMO = SongMO(entity: SongMO.entity(), insertInto: context)
                songMO.artistId = Int32(selectedSong.artistId!)
                songMO.artistName = selectedSong.artistName
                songMO.artworkUrl100 = selectedSong.artworkUrl100
                songMO.artworkUrl60 = selectedSong.artworkUrl60
                songMO.collectionId = Int32(selectedSong.collectionId!)
                songMO.collectionName = selectedSong.collectionName
                songMO.collectionViewUrl = selectedSong.collectionViewUrl
                songMO.previewUrl = selectedSong.previewUrl
                songMO.trackId = Int32(selectedSong.trackId!)
                songMO.trackName = selectedSong.trackName
                songMO.trackViewUrl = selectedSong.trackViewUrl
                
                appDelegate.saveContext()
                
                
                self.busquedasAnteriores.append(selectedSong)
                
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do{
            let busquedaAnterior = try context.fetch(SongMO.fetchRequest())
            
            self.busquedasAnteriores = busquedaAnterior.map(
                { (songMO ) -> Song in
                    return (songMO as! SongMO).getSong()
                }
            )
            
            print("Busqueda correcta, \(busquedaAnterior.count) resultados encontrados")
        }catch let error as NSError {
            print("No se pudo obtener busqueda anterior. \(error), \(error.localizedDescription)")
        }
    }
    
    
    func displayResults(viewModel: Search.FetchResults.ViewModel)
    {
        displayedSongs = viewModel.displayedResults
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        if displayedSongs.count>0{
            return 72
        }else{
            if indexPath.row == 1{
                return 31
            }
            return 72
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if displayedSongs.count>0{
            return displayedSongs.count
        }else{
            return 2 + busquedasAnteriores.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if displayedSongs.count == 0 {
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoEncontradoCell") as?NoEncontradoTableViewCell else {
                    return UITableViewCell();
                }
                
                cell.textoNoEncontrado.text = (searchedText.count>2) ? "Término no encontrado":"Inicia una búsqueda, ingresa 3 o más letras"
                return cell
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeparatorTableViewCell") as?SeparatorTableViewCell else {
                    return UITableViewCell();
                }
                
                
                return cell
                
                
            }else{
                let result = busquedasAnteriores[indexPath.row - 2]
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as?SearchTableViewCell else {
                    return UITableViewCell();
                }
                cell.nombreArtista.text = result.artistName
                cell.nombreCancion.text = result.trackName
                
                return cell
                
            }
            
            
            
        }else{
            let result = displayedSongs[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as?SearchTableViewCell else {
                return UITableViewCell();
            }
            cell.nombreArtista.text = result.artistName
            cell.nombreCancion.text = result.trackName
            
            return cell
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //Limpia la busqueda si se borra el texto
        guard let query = searchBar.text, query != "", query.count>2 else {
            displayedSongs = []
            tableView.reloadData()
            self.searchedText = ""
            return
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        //Se activa la búsqueda cuando se presiona buscar o enter
        guard let query = searchBar.text, query != "", query.count>2 else {
            displayedSongs = []
            tableView.reloadData()
            self.searchedText = ""
            return
        }
        self.searchedText = query
        let request = Search.FetchResults.Request(query: query)
        interactor?.search(request: request)
        
    }
    
}
