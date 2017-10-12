//
//  RandomizationViewController.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/20.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit

class RandomizationViewController: ExampleViewController {

    var scene: RandomizationScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scene = RandomizationScene(size: skView.frame.size)
        skView.presentScene(scene)

        let segmentedControl = UISegmentedControl(items: ["Random", "Gaussian", "Shuffled"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(RandomizationViewController.segmentedControlDidChange(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
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

    @objc func segmentedControlDidChange(_ sender: UISegmentedControl) {
        scene.distributionIndex = sender.selectedSegmentIndex
    }
}
