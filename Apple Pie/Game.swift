//
//  Game.swift
//  Apple Pie
//
//  Created by Aleksey Peredreev on 10.09.2019.
//  Copyright © 2019 Aleksey Peredreev. All rights reserved.
//

import Foundation

struct Game {
    var word: String // guessed word
    var incorrectMovesRemaining: Int // Incorrect tries remaining
    var guessedLetters: [Character] // Tapped buttons list
    
    // Tapped button processing
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        
        // Letter contain checking
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
