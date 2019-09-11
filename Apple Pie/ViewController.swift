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
        "apple",
        "melon",
        "banana",
        "helicopter",
        "house",
        "table",
        "square",
        "watermelon",
        "milk",
        "cat",
        "wind"
    ]
    
    // Maximum incorrect tries
    let incorrectMovesAllowed = 7
    
    // Wins and loses amount
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
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
        if !listOFWords.isEmpty {
        let newWord = listOFWords.removeFirst()
        
        currentGame = Game (
            word: newWord,
            incorrectMovesRemaining: incorrectMovesAllowed,
            guessedLetters: []
        )
        
        enableLetterButtons(true)
        
        } else {
            enableLetterButtons(false)
        }
        updateUI()
    }
    
    // buttons enabling/disbling
    func enableLetterButtons(_ enable: Bool) {
        for button in buttons {
            button.isEnabled = enable
        }
    }

    // interface updating
    func updateUI() {
        // Image updating
        let imageName = "Tree \(currentGame.incorrectMovesRemaining)"
        let image = UIImage(named: imageName)
        treeImageView.image = image
        
        // Guessed word update
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpaces = letters.joined(separator: " ")
        
        wordLabel.text = wordWithSpaces
        
        // Scores updating
        scoreLabel.text = "WINS: \(totalWins), LOSSES: \(totalLosses)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false // Tapped button disabling
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        
        currentGame.playerGuessed(letter: letter)
        
        updateGameState()
    }
    // Game over checking
    func updateGameState() {
        if currentGame.incorrectMovesRemaining < 1 {
            // Round loose
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord.lowercased() {
            // Round win
            totalWins += 1
        }
        
        updateUI()
    }
    
}

