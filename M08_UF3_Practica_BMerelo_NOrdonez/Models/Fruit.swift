//
// Created by Nil Ordoñez Romera on 17/5/18.
// Copyright (c) 2018 Nil Ordoñez. All rights reserved.
//

import UIKit

let imagesNamesArray = ["apple", "cherry", "grape", "orange", "pear", "raspberry", "strawberry", "watermelon"]

class Fruit: Actor {


    class func generateFruit(gameAreaSize: CGSize, speed: CGFloat = 8) -> Fruit {
        let radius: CGFloat = 25
        let x: CGFloat = 2 * radius + CGFloat(arc4random() % UInt32(gameAreaSize.width - radius * 2 - radius * 2))
        let center: CGPoint = CGPoint(x: x, y: -radius)
        let index = Int(arc4random() % UInt32(imagesNamesArray.count))
        let imageName = imagesNamesArray[index]

        let fruit = Fruit(center: center, radius: radius, imageName: imageName)
        fruit.speed = speed
        return fruit
    }

    override func updateLocation(_ controller: GameViewController) {
        var newCenter: CGPoint = self.imageView.center
        newCenter.y = newCenter.y + self.speed
        self.imageView.center = newCenter
        if (newCenter.y - self.radius) > controller.gameAreaSize().height {
            //todo: restar puntuacion
            controller.removeActor(self)
        }
    }
}
