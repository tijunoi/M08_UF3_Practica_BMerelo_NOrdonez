//
//  ViewController.swift
//  M08_UF3_Practica_BMerelo_NOrdonez
//
//  Created by Nil Ordoñez Romera on 3/5/18.
//  Copyright © 2018 Nil Ordoñez. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    //View
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    

    var spaceshipAltitude: CGFloat = 150

    var game: Game?
    //Guardamos el display link para poder acceder en cada momento al frame rate, ya que varía segun el estado del dispositivo
    lazy var displayLink: CADisplayLink = CADisplayLink(target: self, selector: #selector(updateScene))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        //NotificationCenter.default.addObserver(self, selector: #selector(guardarEstadoJuego), name: Notification.Name.UIApplicationWillResignActive, object: UIApplication.shared)

        if self.game == nil {
            self.game = Game()
            createPlayer(nil)
            self.game?.isGameRunning = true
        } else {
            //self.view.addSubview(self.game?.player?.imageView)
        }


        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(tapGestureDone(_:)))
        self.view.addGestureRecognizer(panGesture)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true

        displayLink.add(to: .current, forMode: .defaultRunLoopMode)
    }

    private func createPlayer(_ position: CGPoint?) {

        if let position = position {
            self.game?.player = Player(center: position, radius: 25, imageName: "player")
            let center = self.game?.player?.imageView.center
            self.game?.player?.imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.game?.player?.imageView.center = center!
            self.game?.player?.moveToPoint = self.game?.player?.imageView.center
        } else {
            let center = CGPoint(x: self.view.frame.midX, y: self.view.frame.maxY - spaceshipAltitude)
            self.game?.player = Player(center: center, radius: 25, imageName: "player")
            self.game?.player?.imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.game?.player?.imageView.center = center

            self.game?.player?.moveToPoint = self.game?.player?.imageView.center
        }

        if let imagen = self.game?.player?.imageView {
            self.view.addSubview(imagen)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    @objc func tapGestureDone(_ sender: UIGestureRecognizer) {
        let tapPoint = sender.location(in: self.view)
        if let pan = sender as? UIPanGestureRecognizer {
            //We need to get the actual framerate to determine the speed of the spaceship movement
            let actualFramesPerSecond = 1 / (displayLink.targetTimestamp - displayLink.timestamp)
            //Speed of the pan gesture expressed in points per second
            let velocityPPS: CGPoint = pan.velocity(in: self.view)

            var targetSpeed = abs(Double(velocityPPS.x) / actualFramesPerSecond)

            //If new speed is less than 10, leave at 10 so the spaceship doesn't move that slowly
            if targetSpeed < 10 {
                targetSpeed = 10
            }
            self.game?.player?.speed = CGFloat(targetSpeed)
        }
        self.game?.player?.moveToPoint = tapPoint
    }

    @objc func updateScene() {

        if let game = self.game {
            if game.isGameRunning {

                //Create fruit every 5 seconds
                if (game.stepNumber % (60 * 3) == 0 && game.stepNumber != 0) {
                    let fruit = Fruit.generateFruit(gameAreaSize: gameAreaSize(), speed: 10) //todo: update speed acording to score
                    game.fruits.append(fruit)
                    self.view.addSubview(fruit.imageView)
                }

                //Update actor's locations

                for actor in game.fruits {
                    actor.updateLocation(self)
                }

                //Check collisions

                for actor in game.fruits {
                    if game.player!.overlapsWith(actor: actor) {
                        game.player!.afterCollision(actor: actor, controller: self)

                    }

                }

                //Remove fruits from scene

                self.executeRemovalOfActors()

                //Increment step

                game.stepNumber += 1

                //Update View labels

                scoreLabel.text = "\(game.points)"
                livesLabel.text = "\(game.remainingLives)"


                //Check if game is over

                if game.isGameOver {
                    game.isGameRunning = false
                }

                //If gameOverDetected SHOW ALERT

                if !(game.isGameRunning) {
                    self.saveScores()
                    self.showGameAlert()
                }

            }
        }

        self.game?.player?.updateLocation(self)
    }

    private func saveScores(){
        if let data = UserDefaults.standard.object(forKey: "SCORES_KEY") as? Data{
            let decoder = PropertyListDecoder()
            let arrScores = try? decoder.decode(HighScores.self, from: data)
            arrScores?.addScores(newScore: self.game!.points)
            
            let encoder = PropertyListEncoder()
            let data = try? encoder.encode(arrScores!)
            UserDefaults.standard.set(data, forKey: "SCORES_KEY")
        }
        
        
    }
    
    func gameAreaSize() -> CGSize {
        return self.view.frame.size
    }

    func removeActor(_ actor: Actor) {
        game?.toBeRemoved.append(actor)
    }

    func executeRemovalOfActors() {

        if let game = self.game {
            for actor in game.toBeRemoved {
                if let actorToDelete = searchElementInArray(actor: actor, game.fruits) {
                    if let index = game.fruits.index(of: actorToDelete) {
                        game.fruits.remove(at: index)
                    }
                }

                actor.imageView.removeFromSuperview()
            }
            game.toBeRemoved.removeAll()
        }
    }

    func searchElementInArray(actor: Actor, _ actors: [Actor]) -> Actor? {
        var actorToReturn: Actor? = nil
        for element in actors {
            if element == actor {
                actorToReturn = element
                break
            }
        }
        return actorToReturn
    }

    func showGameAlert() {
        let alertController = UIAlertController(title: "GAME OVER", message: "Your score was \(game!.points)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "GO TO MAIN SCREEN", style: .default) {
            UIAlertAction in

            if let controller = self.storyboard?.instantiateInitialViewController() {
                self.present(controller, animated: true)
            }


        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }

    @objc func guardarEstadoJuego() {
        let encoder = PropertyListEncoder()
        //let data = try? encoder.encode(self.game!)
        //NSKeyedArchiver.archiveRootObject(data, toFile: "RUTA")

        if let nc = self.storyboard?.instantiateInitialViewController() {
            self.present(nc, animated: true)
        }
    }


}

