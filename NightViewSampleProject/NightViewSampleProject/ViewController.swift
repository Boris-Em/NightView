//
//  ViewController.swift
//  NightViewSampleProject
//
//  Created by Bobo on 7/10/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nightView: NightView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCustomization" {
            if let navVC = segue.destination as? UINavigationController, let customizationVC = navVC.topViewController as? CustomizationTableViewController {
                customizationVC.nightView = nightView
            }
        }
    }

}

