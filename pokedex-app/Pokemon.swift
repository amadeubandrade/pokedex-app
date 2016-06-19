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
    
    var pokeUrl: String {
        return _pokeURL
    }
    
    var height: String {
        if _height == nil {
            _height = "Unknown"
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = "Unknown"
        }
        return _weight
    }
    
    var type: String {
        if _type == nil {
            _type = "Unknown"
        }
        return _type
    }
    
    var about: String {
        if _about == nil {
            _about = "Unknown"
        }
        return _about
    }
    
    var hp: Int {
        if _hp == nil {
            _hp = 0
        }
        return _hp
    }
    
    var atk: Int {
        if _atk == nil {
            _atk = 0
        }
        return _atk
    }
    
    var def: Int {
        if _def == nil {
            _def = 0
        }
        return _def
    }
    
    var spe: Int {
        if _spe == nil {
            _spe = 0
        }
        return _spe
    }
    
    var spa: Int {
        if _spa == nil {
            _spa = 0
        }
        return _spa
    }
    
    var spd: Int {
        if _spd == nil {
            _spd = 0
        }
        return _spd
    }
    
    var whereToFind: String {
        if _whereToFind == nil {
            _whereToFind = "Unknown"
        }
        return _whereToFind
    }

    var evo1Name: String {
        if _evo1Name == nil {
            _evo1Name = ""
        }
        return _evo1Name
    }
    
    var evo1ID: String {
        if _evo1ID == nil {
            _evo1ID = ""
        }
        return _evo1ID
    }
    
    var evo2Name: String {
        if _evo2Name == nil {
            _evo2Name = ""
        }
        return _evo2Name
    }
    
    var evo2ID: String {
        if _evo2ID == nil {
            _evo2ID = ""
        }
        return _evo2ID
    }
    
    
    // MARK: - Initializer
    
    init(name: String, pokedexId: Int) {
        _name = name.capitalizedString
        _pokedexId = pokedexId
        _pokeURL = "\(URL_BASE)\(URL_POKEMON)\(_pokedexId)/"
    }
    
    // MARK: - Functions
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let group = dispatch_group_create()
        
        let url = NSURL(string: _pokeURL)!
        dispatch_group_enter(group)
        Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                //Height and Weight
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let weight = dict["weight"] as? String {
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
                    self._spa = spec_attack
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
                        dispatch_group_enter(group)
                        Alamofire.request(.GET, nsurl).responseJSON(completionHandler: { response in
                            let aboutResp = response.result
                            if let aboutDict = aboutResp.value as? Dictionary<String, AnyObject> {
                                if let pokeDesc = aboutDict["description"] as? String {
                                    self._about = pokeDesc
                                }
                            }
                            dispatch_group_leave(group)
                        })
                    }
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
                }
                //Evolutions
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    //First evolution
                    if let evoName1 = evolutions[0]["to"] as? String {
                        
                        if evoName1.rangeOfString("mega") == nil {
                    
                            self._evo1Name = evoName1
                            if let evoID1 = evolutions[0]["resource_uri"] as? String {
                                let aux = evoID1.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let id = aux.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._evo1ID = id
                            
                                //Second evolution
                                let evoUrl = NSURL(string: "\(URL_BASE)\(URL_POKEMON)\(self._evo1ID)/")!
                                dispatch_group_enter(group)
                                Alamofire.request(.GET, evoUrl).responseJSON(completionHandler: { evosResponse in
                                    let evosResult = evosResponse.result
                                    if let evolutionDict = evosResult.value as? Dictionary<String, AnyObject> {
                                        if let evolution = evolutionDict["evolutions"] as? [Dictionary<String, AnyObject>] where evolution.count > 0 {
                                            if let evoName2 = evolution[0]["to"] as? String {
                                                if evoName2.rangeOfString("mega") == nil {
                                                    self._evo2Name = evoName2
                                                    if let evoID2 = evolution[0]["resource_uri"] as? String {
                                                        let aux = evoID2.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                                        let id = aux.stringByReplacingOccurrencesOfString("/", withString: "")
                                                        self._evo2ID = id
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    dispatch_group_leave(group)
                                })
                            }
                        }
                    }
                }
                //where to find
                
                // TODO : - Correct sound when go back!

                
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
            dispatch_group_leave(group)
        })
        dispatch_group_notify(group, dispatch_get_main_queue()) {
            completed()
        }
    }

}