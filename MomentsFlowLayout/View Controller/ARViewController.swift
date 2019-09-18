//
//  ARViewController.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-09-17.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    let arSCNView = ARSCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupARSCNView()
    }

    var defaultConfiguration: ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        return configuration
    }
    
    func setupARSCNView() {
        arSCNView.frame = self.view.frame
        arSCNView.scene = SCNScene()
        arSCNView.delegate = self
        arSCNView.session.delegate = self
        arSCNView.autoenablesDefaultLighting = true
        arSCNView.showsStatistics = false
        view.addSubview(arSCNView)
        arSCNView.session.run(defaultConfiguration)
    }
}
