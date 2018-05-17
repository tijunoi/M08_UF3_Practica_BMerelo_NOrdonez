//
// Created by Nil Ordoñez Romera on 17/5/18.
// Copyright (c) 2018 Nil Ordoñez. All rights reserved.
//

import Foundation

class HighScores:Codable {
    var highscores: [Int]
    
    init() {
        self.highscores = [Int]()
    }
    
    func addScores(newScore: Int) {
        highscores.append(newScore)
        highscores.sort(){
            $0>$1
        }
        while highscores.count>10{
            highscores.remove(at: 10)
        }
    }
}

