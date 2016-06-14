//
//  PokemonDetailsVC.swift
//  pokedex-app
//
//  Created by Amadeu Andrade on 14/06/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    // MARK : - IBOutlets
    
    @IBOutlet weak var topLbl: UILabel!
    
    
    // MARK : - Properties
    
    var pokemon: Pokemon!
    var audioPlayer: ApplicationMusic!
    
    
    // MARK : - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pokemon)
    }
    
    
    // MARK : - IBActions
    
    @IBAction func onMusicBtnPressed(sender: UIButton) {
        if audioPlayer.isPlaying() {
            audioPlayer.stopAudio()
            sender.alpha = 0.5
        } else {
            audioPlayer.playAudio()
            sender.alpha = 1.0
        }
    }



}
