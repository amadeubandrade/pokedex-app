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
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeHeight: UILabel!
    @IBOutlet weak var pokeWeight: UILabel!
    @IBOutlet weak var pokeType: UILabel!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var atkLbl: UILabel!
    @IBOutlet weak var defLbl: UILabel!
    @IBOutlet weak var speLbl: UILabel!
    @IBOutlet weak var spaLbl: UILabel!
    @IBOutlet weak var spdLbl: UILabel!
    @IBOutlet weak var hpBar: UIProgressView!
    @IBOutlet weak var atkBar: UIProgressView!
    @IBOutlet weak var defBar: UIProgressView!
    @IBOutlet weak var speBar: UIProgressView!
    @IBOutlet weak var spaBar: UIProgressView!
    @IBOutlet weak var spdBar: UIProgressView!
    @IBOutlet weak var whereToFindLbl: UILabel!
    @IBOutlet weak var evo1Img: UIImageView!
    @IBOutlet weak var evo2Img: UIImageView!
    
    
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
    
    @IBAction func onBackBtnPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }



}
