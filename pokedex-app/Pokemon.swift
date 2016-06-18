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
    private var _evo1Name: String!
    private var _evo1ID: String!
    private var _evo2Name: String!
    private var _evo2ID: String!
    
    private var _pokeURL: String!
    
    // MARK: - Computed Properties

    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var height: Int {
        return _height
    }
    
    var weight: Int {
        return _weight
    }
    
    var type: String {
        return _type
    }
    
    var about: String {
        return _about
    }
    
    var hp: Int {
        return _hp
    }
    
    var atk: Int {
        return _atk
    }
    
    var def: Int {
        return _def
    }
    
    var spe: Int {
        return _spe
    }
    
    var spa: Int {
        return _spa
    }
    
    var spd: Int {
        return _spd
    }
    
    var whereToFind: String {
        return _whereToFind
    }

    var evo1Name: String {
        return _evo1Name
    }
    
    var evo1ID: String {
        return _evo1ID
    }
    
    var pokeURL: String {
        return _pokeURL
    }
    
    var evo2Name: String {
        return _evo2Name
    }
    
    var evo2ID: String {
        return _evo2ID
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
                //Height and Weight
                if let height = dict["height"] as? Int {
                    self._height = height
                }
                if let weight = dict["weight"] as? Int {
                    self._weight = weight
                }
                //Stats
                if let attack = dict["attack"] as? Int {
                    self._atk = attack
                }
                if let defense = dict["defense"] as? Int {
                    self._def = defense
                }
                if let hp = dict["hp"] as? Int {
                    self._hp = hp
                }
                if let spec_attack = dict["sp_atk"] as? Int {
                    self._atk = spec_attack
                }
                if let spec_defense = dict["sp_def"] as? Int {
                    self._spd = spec_defense
                }
                if let speed = dict["speed"] as? Int {
                    self._spe = speed
                }
                //About
                if let about = dict["descriptions"] as? [Dictionary<String, AnyObject>] where about.count > 0 {
                    if let url = about[0]["resource_uri"] as? String {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON(completionHandler: { response in
                            let aboutResp = response.result
                            if let aboutDict = aboutResp.value as? Dictionary<String, AnyObject> {
                                if let pokeDesc = aboutDict["description"] as? String {
                                    self._about = pokeDesc
                                }
                            }
                        })
                    }
                } else {
                    self._about = "Unknown"
                }
                //Types
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] where types.count > 0 {
                    if let type = types[0]["name"] as? String {
                        self._type = type.capitalizedString
                    }
                    if types.count > 1 {
                        for index in 1..<types.count {
                            if let typeName = types[index]["name"] as? String {
                               self._type! += "/\(typeName.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = "Unknown"
                }
                //Evolutions
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                
                }
                //where to find
//                let encoutersUrl = NSURL(string: "\(self._pokeURL)encounters")!
//                Alamofire.request(.GET, encoutersUrl).responseJSON(completionHandler: { encountersResponse in
//                    let encountersResult = encountersResponse.result
//                    if let encountersDict = encountersResult.value as? [Dictionary<String, AnyObject>] where encountersDict.count > 0 {
//                        print(encountersDict)
//                        if let location = encountersDict[0]["location_area"]!["name"] as? String {
//                            self._whereToFind = location
//                        }
//                    } else {
//                        self._whereToFind = ""
//                    }
//                    print(encountersResult.value)
//                    print(self._whereToFind)
//                })
                

            }
        }
        
    }

}