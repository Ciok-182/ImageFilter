//
//  ViewController.swift
//  MenuAdicional
//
//  Created by Jorge Encinas on 1/21/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var filteredImage: UIImage?
    
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filterButton: UIButton!
    
    
    
    @IBOutlet weak var imageToggle: UIButton!
    
    @IBAction func onImageToggle(_ sender: UIButton) {
        
        if(imageToggle.isSelected){
            let image = UIImage(named: "sampleImage.png")
            imageView.image = image
            imageToggle.isSelected = false
        } else{
            imageView.image = filteredImage
            imageToggle.isSelected = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageToggle.setTitle("Show before image", for: .selected)
        
        let image = UIImage(named: "sampleImage.png")
        let myRGBA = RGBAImage(image: image!)!
        

        let avgRed = 51
//        let avgGreen = 125
//        let avgBlue = 115
        
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                
//                let redDelta = Int(pixel.R) - avgRed
                let redDiff = Int(pixel.R) - avgRed
                var modifier = 1 + 4 * (Double(y) / Double(myRGBA.height))
                
                if(Int(pixel.R) < avgRed){
                    modifier = 1
                }
                
                pixel.R = UInt8(max(min(255,Int(round(Double(avgRed) + modifier * Double(redDiff)))),0))
                myRGBA.pixels[index] = pixel
                
                
            }
        }
        filteredImage = myRGBA.toUIImage()
    }

    @IBAction func onFilter(_ sender: UIButton) {
        view.addSubview(secondaryMenu)
        
    }
    
    

}

