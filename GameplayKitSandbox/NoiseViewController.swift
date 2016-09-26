//
//  NoiseViewController.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 9/25/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit

class NoiseViewController: ExampleViewController {

    var scene: NoiseScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scene = NoiseScene(size: skView.frame.size)
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
