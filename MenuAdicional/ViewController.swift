//
//  ViewController.swift
//  MenuAdicional
//
//  Created by Jorge Encinas on 1/21/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filterButton: UIButton!
    
    
    @IBAction func onNewPhoto(_ sender: UIButton) {
        
        let actionSheet = UIAlertController.init(title: "New photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction.init(title: "Camera", style: .default,
                                                 handler: {action in
                                                    self.showCamara()
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Album", style: .default,
                                                 handler: {action in
                                                    self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    
    }
    
    func showCamara(){
        let camaraPicker = UIImagePickerController()
        camaraPicker.delegate = self
        camaraPicker.sourceType = .camera
        self.present(camaraPicker, animated: true, completion: nil)
        
    }
    
    func showAlbum(){
        let camaraPicker = UIImagePickerController()
        camaraPicker.delegate = self
        camaraPicker.sourceType = .photoLibrary
        self.present(camaraPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onImageToggle(_ sender: UIButton) {
        
//        if(imageToggle.isSelected){
//            let image = UIImage(named: "sampleImage.png")
//            imageView.image = image
//            imageToggle.isSelected = false
//        } else{
//            imageView.image = filteredImage
//            imageToggle.isSelected = true
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondaryMenu.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        
//        imageToggle.setTitle("Show before image", for: .selected)
        
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

    @IBAction func onShare(_ sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        self.present(activityController, animated: true, completion: nil)
    }
    
    
    @IBAction func onFilter(_ sender: UIButton) {
        
        if(sender.isSelected){
            hideSecondaryMenu()
            sender.isSelected = false
        }else{
            showSecondaryMenu()
            sender.isSelected = true
        }
       
        
    }
    
    
    
    func showSecondaryMenu(){
        
        view.addSubview(secondaryMenu)
        let bottomConstraint = secondaryMenu.bottomAnchor.constraint(equalTo: bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraint(equalTo: view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraint(equalToConstant: 44)
        NSLayoutConstraint.activate([bottomConstraint,leftConstraint,rightConstraint,heightConstraint])
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            
            self.secondaryMenu.alpha = 1
        })
    }
    
    func hideSecondaryMenu(){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.secondaryMenu.alpha = 0
        }) { completed in
            if completed == true{
                self.secondaryMenu.removeFromSuperview()
            }
        }
    }
    
    

}

