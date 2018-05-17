//
//  Controller.swift
//  M08_UF3_Practica_BMerelo_NOrdonez
//
//  Created by Nil Ordoñez Romera on 16/5/18.
//  Copyright © 2018 Nil Ordoñez. All rights reserved.
//

import UIKit

class Game {
    var player: Player?
    var points: Int = 0
    var lives: Int = 3
    var errors: Int = 0
    var remainingLives: Int {
        return lives - errors
    }

    var isGameOver: Bool {
        return remainingLives < 1
    }


    //Game logic
    var isGameRunning: Bool = true
    var stepNumber: Int = 0

    var fruits: [Actor] = [Actor]()
    var toBeRemoved: [Actor] = [Actor]()

    
    init() {
        
    }

    func addPoint() {
        points += 1
    }

    func addError() {
        errors += 1
    }



}
