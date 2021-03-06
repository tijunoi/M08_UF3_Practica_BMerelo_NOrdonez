//
//  Actor.swift
//  M08_UF3_Practica_BMerelo_NOrdonez
//
//  Created by Nil Ordoñez Romera on 7/5/18.
//  Copyright © 2018 Nil Ordoñez. All rights reserved.
//

import Foundation
import UIKit

var nextId: Int = 0

class Actor: Equatable {

    var id: Int
    var speed: CGFloat
    var radius: CGFloat
    var imageView: UIImageView
    
    init(center: CGPoint, radius: CGFloat, imageColor: UIColor) {
        self.id = nextId
        nextId += 1
        self.radius = radius
        let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.imageView = UIImageView(frame: rect)
        self.imageView.backgroundColor = imageColor
        self.imageView.center = center
        self.speed = 8
    }
    
    init(center: CGPoint, radius: CGFloat, imageName: String) {
        self.id = nextId
        nextId += 1
        self.radius = radius
        let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.imageView = UIImageView(image: UIImage(named: imageName))
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.frame = rect
        self.imageView.center = center
        self.speed = 8
    }


    func overlapsWith(actor: Actor) -> Bool {
        let xdist = Float(abs(self.imageView.center.x-actor.imageView.center.x))
        let ydist = Float(abs(self.imageView.center.y-actor.imageView.center.y))
        let distance: Float = sqrt(pow(xdist, 2) + pow(ydist, 2))
        return distance<Float(self.radius + actor.radius)
    }
    
    func updateLocation(_ controller: GameViewController) {
        
    }

    static func ==(lhs: Actor, rhs: Actor) -> Bool {
        return lhs.id == rhs.id
    }
}
