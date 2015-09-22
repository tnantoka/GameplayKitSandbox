//
//  StateViewController.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/20.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

class StateViewController: ExampleViewController {

    var scene: StateScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scene = StateScene(size: skView.frame.size)
        skView.presentScene(scene)

        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "viewDidDoubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: "viewDidTap:")
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        view.addGestureRecognizer(tapRecognizer)
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

    func viewDidDoubleTap(sender: UIGestureRecognizer) {
        scene.createRain()
    }

    func viewDidTap(sender: UIGestureRecognizer) {
        scene.createSpark()
    }
}
