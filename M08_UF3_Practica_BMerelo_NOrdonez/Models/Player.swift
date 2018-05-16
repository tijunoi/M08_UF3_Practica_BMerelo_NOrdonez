//
//  Player.swift
//  M08_UF3_Practica_BMerelo_NOrdonez
//
//  Created by Nil Ordoñez Romera on 15/5/18.
//  Copyright © 2018 Nil Ordoñez. All rights reserved.
//

import UIKit

class Player: Actor{
    
    var moveToPoint:CGPoint?

    override func updateLocation(){
        if let newPoint = moveToPoint{
            if !(newPoint.x == self.imageView.center.x) && !(newPoint.y==self.imageView.center.y) {
                var center = self.imageView.center
                
                let dx:CGFloat = newPoint.x - center.x
                
                var dxf:CGFloat = self.speed
                
                dxf = dx < 0 ? dxf * -1 : dxf
                
                center.x = center.x + dxf
                
                if (abs(newPoint.x - center.x) < self.speed) {
                    center.x = newPoint.x
                }
                
                self.imageView.center = center
            }
        }
    }
}
