//
//  Pokemon.swift
//  pokedex-app
//
//  Created by Amadeu Andrade on 11/06/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {

    // MARK: - Properties
    
    private var _name: String!
    private var _pokedexId: Int!

    private var _height: String!
    private var _weight: String!
    private var _type: String!
    private var _about: String!
    private var _hp: Int!
    private var _atk: Int!
    private var _def: Int!
    private var _spe: Int!
    private var _spa: Int!
    private var _spd: Int!
    private var _whereToFind: String!
    
    private var _pokeURL: String!
    
    // MARK: - Computed Properties

    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    // MARK: - Initializer
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        _pokeURL = "\(URL_BASE)\(URL_POKEMON)\(_pokedexId)/"
    }
    
    // MARK: - Functions
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokeURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            print(result.value.debugDescription)
        }
        
    }

}