//
//  ViewController.swift
//  Apple Pie
//
//  Created by Aleksey Peredreev on 07.09.2019.
//  Copyright © 2019 Aleksey Peredreev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Words list to guess
    var listOFWords = [
        "melon",
        "banana",
        "helicopter",
        "house",
        "table",
        "square"
    ]
    
    // Maximum incorrect tries
    let incorrectMovesAllowed = 7
    
    // Wins and loses amount
    var totalWins = 0
    var totalLosses = 0
    
    // Current game
    var currentGame: Game!

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // New round start
        newRound()
    }
    
    // Starts new round
    func newRound() {
        let newWord = listOFWords.removeFirst()
        
        currentGame = Game (
            word: newWord,
            incorrectMovesRemaining: incorrectMovesAllowed
        )
        updateUI()
    }

    // interface updating
    func updateUI() {
        // Image updating
        let imageName = "Tree \(currentGame.incorrectMovesRemaining)"
        let image = UIImage(named: imageName)
        treeImageView.image = image
        
        // Scores updating
        scoreLabel.text = "WINS: \(totalWins), LOSES: \(totalLosses)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false // Tapped button disabling
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        
        currentGame.playerGuessed(letter: letter)
        
        updateUI()
    }
    
}

