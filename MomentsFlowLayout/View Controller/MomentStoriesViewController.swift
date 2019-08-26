//
//  MomentStoriesViewController.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-22.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentStoriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        view.addGestureRecognizer(dismissTap)
    }
    
    @objc func onTap() {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
