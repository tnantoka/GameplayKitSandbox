//
//  NoiseScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 9/25/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import GameplayKit

class NoiseScene: ExampleScene {
    override func createSceneContents() {
        let noises: [(String, GKNoiseSource)] = [
            ("Billow", GKBillowNoiseSource()),
            ("Checkerboard", GKCheckerboardNoiseSource(squareSize: 0.1)),
            ("Constant", GKConstantNoiseSource()),
            ("Cylinders", GKCylindersNoiseSource()),
            ("Perlin", GKPerlinNoiseSource()),
            ("Ridged", GKRidgedNoiseSource()),
            ("Spheres", GKSpheresNoiseSource()),
            ("Voronoi", GKVoronoiNoiseSource()),
        ]

        let height = frame.height / CGFloat(noises.count / 2)
        let width = frame.midX

        for (i, source) in noises.enumerated() {
            let y = frame.maxY - height * CGFloat(i / 2)
            let x = frame.midX * CGFloat(i % 2)
            
            let noise = GKNoise(source.1)
            let noiseMap = GKNoiseMap(noise)
            let texture = SKTexture(noiseMap: noiseMap)
            let noiseNode = SKSpriteNode(texture: texture, size: CGSize(width: width, height: height))
            noiseNode.position = CGPoint(x: x, y: y)
            noiseNode.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            addChild(noiseNode)

            let labelNode = SKLabelNode(text: source.0)
            labelNode.verticalAlignmentMode = .top
            labelNode.horizontalAlignmentMode = .left
            labelNode.color = UIColor.white
            labelNode.fontSize = 26.0
            
            let overlayNode = SKSpriteNode(color: UIColor(white: 0.0, alpha: 0.8), size: labelNode.frame.size)
            overlayNode.position = CGPoint(x: x, y: y)
            overlayNode.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            overlayNode.addChild(labelNode)
            
            addChild(overlayNode)
        }
    }
}
