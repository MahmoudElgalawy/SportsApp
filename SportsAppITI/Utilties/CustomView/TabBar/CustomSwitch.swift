//
//  CustomSwitch.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit

class CustomSwitch: UISwitch {




    override func draw(_ rect: CGRect) {
        DispatchQueue.main.async {
            self.transform = CGAffineTransform(scaleX: 5, y: 2)


        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {


        guard let darkImage = UIImage(named: "boy"),
                     let lightImage = UIImage(named: "girl") else {
                   print("Error: Images not found")
                   return
               }

        // UIImage(named: "dark")

        onImage = resizeImage(image: lightImage, targetSize: (width: 0.9, height: 1))
        offImage = resizeImage(image: darkImage, targetSize: (width: 0.9, height: 1))

        onTintColor = UIColor.lightGray

        addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        switchChanged()
    }

    @objc private func switchChanged() {
        if isOn {
            thumbTintColor = UIColor(patternImage: onImage!)
        } else {
            thumbTintColor = UIColor(patternImage: offImage!)
        }
    }

    private func resizeImage(image: UIImage, targetSize: (width:Double,height:Double)) -> UIImage {

            let size = image.size

            let targetWidth = self.frame.width*targetSize.width
            let targetHeight = self.frame.height*targetSize.height
            let frame = CGSize(width: targetWidth, height: targetHeight)

            let widthRatio  = frame.width  / size.height
            let heightRatio = frame.height / size.height

            // Determine the scale factor that preserves aspect ratio
            let scaleFactor = min(widthRatio, heightRatio)

            // Compute the new image size that preserves aspect ratio
            let scaledImageSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

            // Create a new context with the target size
            UIGraphicsBeginImageContextWithOptions(frame, false, 0)

            // Calculate the position to center the image
            let x = (frame.width - scaledImageSize.width) / 2
            let y = (frame.height - scaledImageSize.height) / 2

            // Draw the image in the context
            image.draw(in: CGRect(origin: CGPoint(x: x, y: y), size: scaledImageSize))

            // Create a new image from the context
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return scaledImage!
        }
    override func layoutSubviews() {
            super.layoutSubviews()
            // Ensure the rounded appearance is maintained during layout changes
            layer.cornerRadius = frame.height / 2
        }
    }




