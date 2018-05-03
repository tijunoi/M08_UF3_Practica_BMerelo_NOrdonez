//
//  ViewController.swift
//  M08_UF3_Practica_BMerelo_NOrdonez
//
//  Created by Nil Ordoñez Romera on 3/5/18.
//  Copyright © 2018 Nil Ordoñez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var spaceship: Spaceship?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.spaceship = Spaceship(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.spaceship!.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        self.spaceship!.moveToPoint = self.spaceship!.center
        self.view.addSubview(self.spaceship!)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateScene))
        //displayLink.add(to: self.view.current, forMode: <#T##RunLoopMode#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @objc func tapGestureDone(){
        
    }
    
    @objc func updateScene(){
        
    }


}

