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