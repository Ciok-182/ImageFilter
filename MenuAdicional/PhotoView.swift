//
//  PhotoView.swift
//  MenuAdicional
//
//  Created by Jorge Encinas on 2/8/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import UIKit

class PhotoView: UIImageView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first{
            let location = touch.location(in: self)
            print("X: \(location.x) Y: \(location.y)")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }

}
