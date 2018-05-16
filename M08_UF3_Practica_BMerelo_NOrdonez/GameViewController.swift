//
//  ViewController.swift
//  M08_UF3_Practica_BMerelo_NOrdonez
//
//  Created by Nil Ordoñez Romera on 3/5/18.
//  Copyright © 2018 Nil Ordoñez. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var spaceshipAltitude: CGFloat = 150
    var spaceship: Spaceship?
    
    var game: Game?
    //Guardamos el display link para poder acceder en cada momento al frame rate, ya que varía segun el estado del dispositivo
    lazy var displayLink: CADisplayLink = CADisplayLink(target: self, selector: #selector(updateScene))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.spaceship = Spaceship(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        self.spaceship!.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.maxY - spaceshipAltitude)
//        self.spaceship?.backgroundColor = UIColor.black
//        self.spaceship!.moveToPoint = self.spaceship!.center
//        self.view.addSubview(self.spaceship!)
        
        self.game = Game()
        let center = CGPoint(x: self.view.frame.midX, y: self.view.frame.maxY - spaceshipAltitude)
        self.game?.player = Player(center: center, radius: 25, imageColor: UIColor.black)
        self.game?.player?.moveToPoint = self.game?.player?.imageView.center
        
        if let imagen = self.game?.player?.imageView {
            self.view.addSubview(imagen)
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(tapGestureDone(_:)))
        self.view.addGestureRecognizer(panGesture)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
        
        displayLink.add(to: .current, forMode: .defaultRunLoopMode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @objc func tapGestureDone(_ sender: UIGestureRecognizer){
        let tapPoint = sender.location(in: self.view)
        if let pan = sender as? UIPanGestureRecognizer {
            //We need to get the actual framerate to determine the speed of the spaceship movement
            let actualFramesPerSecond = 1 / (displayLink.targetTimestamp - displayLink.timestamp)
            //Speed of the pan gesture expressed in points per second
            let velocityPPS:CGPoint = pan.velocity(in: self.view)
            
            var targetSpeed = abs(Double(velocityPPS.x) / actualFramesPerSecond)
            
            //If new speed is less than 10, leave at 10 so the spaceship doesn't move that slowly
            if targetSpeed < 10 {
                targetSpeed = 10
            }
            self.game?.player?.speed = CGFloat(targetSpeed)
        }
        self.game?.player?.moveToPoint = tapPoint
    }
    
    @objc func updateScene(){
        self.game?.player?.updateLocation()
    }


}

