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

    private var _height: Int!
    private var _weight: Int!
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

            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let height = dict["height"] as? Int {
                    self._height = height
                }
                if let weight = dict["weight"] as? Int {
                    self._weight = weight
                }
                if let stats = dict["stats"] as? [Dictionary<String, AnyObject>] where stats.count > 0 {
                    for stat in stats {
                        let statVal = stat["base_stat"] as? Int
                        let statName = stat["stat"]!["name"] as? String
                        if statName == "speed" {
                            self._spe = statVal
                        } else if statName == "special-defense" {
                            self._spd = statVal
                        } else if statName == "special-attack" {
                            self._spa = statVal
                        } else if statName == "defense" {
                            self._def = statVal
                        } else if statName == "attack" {
                            self._atk = statVal
                        } else if statName == "hp" {
                            self._hp = statVal
                        }
                    }
                }
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] where types.count > 0 {
                    
                    if let type = types[0]["type"]!["name"] as? String {
                        self._type = type.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for index in 1..<types.count {
                            if let typeName = types[index]["type"]!["name"] as? String {
                               self._type! += "/\(typeName.capitalizedString)"
                            }
                        }
                    }
                }
                //about
                //where to find
            }
        }
        
    }

}