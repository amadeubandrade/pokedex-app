//
//  Pokemon.swift
//  pokedex-app
//
//  Created by Amadeu Andrade on 11/06/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation

class Pokemon {

    // MARK: - Properties
    
    private var _name: String!
    private var _pokedexId: Int!
    
    private var _height: String!
    private var _weight: String!
    private var _type: String!
    private var _about: String!
    private var _hp: String!
    private var _atk: String!
    private var _def: String!
    private var _spe: String!
    private var _spa: String!
    private var _spd: String!
    private var _whereToFind: String!
    
    
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
    }

}