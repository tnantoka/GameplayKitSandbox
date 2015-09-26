//
//  MinmaxViewController.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/20.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

class MinmaxViewController: ExampleViewController {

    var scene: MinmaxScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scene = MinmaxScene(size: skView.frame.size)
        scene.didGameOver = { scene, message in
            let alertController = UIAlertController(title: "Game Over", message: message, preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { action in
                scene.reset()
            }
            alertController.addAction(action)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
