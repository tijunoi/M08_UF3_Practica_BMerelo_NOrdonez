//
//  Spaceship.swift
//  M08_UF3_Practica_BMerelo_NOrdonez
//
//  Created by Nil Ordoñez Romera on 3/5/18.
//  Copyright © 2018 Nil Ordoñez. All rights reserved.
//

import UIKit

class Spaceship: UIImageView {
    
    var speed: CGFloat = 1.5 
    var moveToPoint:CGPoint?
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateLocation(){
        if let newPoint = moveToPoint{
            if !(newPoint.x == self.center.x) && !(newPoint.y==self.center.y) {
                var center = self.center
                
                let dx:CGFloat = newPoint.x - center.x
                
                var dxf:CGFloat = self.speed
                
                dxf = dx < 0 ? dxf * -1 : dxf
                
                center.x = center.x + dxf
                
                if (abs(newPoint.x - center.x) < self.speed) {
                    center.x = newPoint.x
                }
                
                self.center = center
            }
        }
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
