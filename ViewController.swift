//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 11/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds) // Making sure everything is working
        view.backgroundColor = .red
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

