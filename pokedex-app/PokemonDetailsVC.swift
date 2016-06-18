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
    @IBOutlet weak var evo1Lbl: UILabel!
    @IBOutlet weak var evo2Lbl: UILabel!
    
    
    // MARK : - Properties
    
    var pokemon: Pokemon!
    var audioPlayer: ApplicationMusic!
    
    
    // MARK : - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLbl.text = pokemon.name
        pokeImg.image = UIImage(named: "\(pokemon.pokedexId)")
        pokemon.downloadPokemonDetails {
            print("HEYYYYYYY")
            self.updateUI()
        }
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
        
    // TODO : - Correct sound when go back!
    }

    
    // MARK : - Functions
    
    func updateUI() {
        pokeID.text = String(pokemon.pokedexId)
        pokeHeight.text = pokemon.height
        pokeWeight.text = pokemon.weight
        pokeType.text = pokemon.type
        aboutLbl.text = pokemon.about
        hpLbl.text = String(pokemon.hp)
        atkLbl.text = String(pokemon.atk)
        defLbl.text = String(pokemon.def)
        speLbl.text = String(pokemon.spe)
        spaLbl.text = String(pokemon.spa)
        spdLbl.text = String(pokemon.spd)
        whereToFindLbl.text = pokemon.whereToFind
        if pokemon.evo1ID == "" {
            evo1Img.hidden = true
            evo1Lbl.text = "No Evolutions"
        } else {
            evo1Img.image = UIImage(named: "\(pokemon.evo1ID)")
            evo1Lbl.text = pokemon.evo1Name
        }
        if pokemon.evo2ID == "" {
            evo2Img.hidden = true
            evo2Lbl.hidden = true
        } else {
            evo2Img.image = UIImage(named: "\(pokemon.evo2ID)")
            evo2Lbl.text = pokemon.evo2Name
        }
    }


}
