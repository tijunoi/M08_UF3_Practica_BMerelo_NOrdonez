//
//  MenuViewController.swift
//  M08_UF3_Practica_BMerelo_NOrdonez
//
//  Created by Bertiwi on 17/05/2018.
//  Copyright © 2018 Nil Ordoñez. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Comprovamos si existe historial de puntuaciones en el dispositivo
        if let data = UserDefaults.standard.object(forKey: "SCORES_KEY") as? Data {
            let decoder = PropertyListDecoder()
            let _ = try? decoder.decode(HighScores.self, from: data)
        } else {
            //Si no existen highscores en el dispositivo se inicializan
            let scores = HighScores()
            let encoder = PropertyListEncoder()
            let data = try? encoder.encode(scores)
            UserDefaults.standard.set(data, forKey: "SCORES_KEY")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(segue: UIStoryboardSegue){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
