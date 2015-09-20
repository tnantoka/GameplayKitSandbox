//
//  ExampleViewController.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/20.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit

class ExampleViewController: UIViewController {

    weak var skView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        edgesForExtendedLayout = .None

        let skView = SKView(frame: view.bounds)
        view.addSubview(skView)
        self.skView = skView

        #if DEBUG
            skView.showsDrawCount = true
            skView.showsFields = true
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            skView.showsQuadCount = true
        #endif
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
