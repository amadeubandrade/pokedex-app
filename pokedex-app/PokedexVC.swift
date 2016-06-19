//
//  ViewController.swift
//  pokedex-app
//
//  Created by Amadeu Andrade on 11/06/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import AVFoundation

class PokedexVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Properties
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var audioPlayer: ApplicationMusic!
    var inSearchMode = false
    
    
    // MARK: - View lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        audioPlayer = ApplicationMusic()
        parsePokemonCSV()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        audioPlayer.playAudio()
    }
    
    
    // MARK: - UICollection View methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
         return filteredPokemons.count
        }
        
        return pokemons.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            var pokemon: Pokemon!
            
            if inSearchMode {
                pokemon = filteredPokemons[indexPath.row]
            } else {
                pokemon = pokemons[indexPath.row]
            }
            cell.configureCell(pokemon)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var pokemon: Pokemon!
        if inSearchMode {
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        
        performSegueWithIdentifier("showPokemonDetails", sender: pokemon)
    }
    
    
    // MARK: - SearchBar
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let text = searchBar.text!.lowercaseString
            filteredPokemons = pokemons.filter({$0.name.rangeOfString(text) != nil})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

    // MARK: - IBActions
    
    @IBAction func onMusicBtnPressed(sender: UIButton) {
        if audioPlayer.isPlaying() {
            audioPlayer.stopAudio()
            sender.alpha = 0.5
        } else {
            audioPlayer.playAudio()
            sender.alpha = 1.0
        }
    }
    
    
    // MARK: - Parsing CSV
    
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                if let pokeName = row["identifier"], let pokeId = Int(row["id"]!) {
                    let pokemon = Pokemon(name: pokeName, pokedexId: pokeId)
                    pokemons.append(pokemon)
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    // MARK : - Prepare For Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPokemonDetails" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailsVC {
                if let pokemon = sender as? Pokemon {
                    detailsVC.pokemon = pokemon
                    detailsVC.audioPlayer = audioPlayer
                }
            }
        }
    }

}

