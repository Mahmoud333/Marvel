//
//  AverageColorImageV.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/26/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.

// AverageColorImageV

import UIKit

class AverageColorImageV: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 2.5)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 3.0
        self.clipsToBounds = false

    }

    let pixelThinner = 5
    
    func analizeImage(_ image: UIImage?, completion: @escaping ([UIColor]) -> ()) {
        
        guard let image = self.image else { return }
                
        findColors(image) { [weak self] imageColors in
            guard let sSelf = self else { return }
            var (primaryColor, secondaryColor, detailColor) = sSelf.findMainColors(imageColors)
            
            if primaryColor == nil { primaryColor = .black }
            if secondaryColor == nil { secondaryColor = .white }
            if detailColor == nil { detailColor = .white }

            completion([primaryColor!, secondaryColor!, detailColor!])
        }
    }
    
    func findColors(_ image: UIImage, completion: @escaping ([String: Int]) -> Void) {
        guard let pixelData = image.cgImage?.dataProvider?.data else { completion([:]); return }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var countedColors: [String: Int] = [:]
        
        let pixelsWide = Int(image.size.width * image.scale)
        let pixelsHigh = Int(image.size.height * image.scale)
        
        //  let widthRange = 0..<pixelsWide
        //  let heightRange = 0..<pixelsHigh
        
        let widthThinner = Int(pixelsWide / pixelThinner) + 1
        let heightThinner = Int(pixelsHigh / pixelThinner) + 1
        let widthRange = stride(from: 0, to: pixelsWide, by: widthThinner)
        let heightRange = stride(from: 0, to: pixelsHigh, by: heightThinner)
        
        for x in widthRange {
            for y in heightRange {
                let pixelInfo: Int = ((pixelsWide * y) + x) * 4
                let color = "\(data[pixelInfo]).\(data[pixelInfo + 1]).\(data[pixelInfo + 2])"
                if countedColors[color] == nil {
                    countedColors[color] = 0
                } else {
                    countedColors[color]! += 1
                }
            }
        }
        
        completion(countedColors)
    }
    
    func findMainColors(_ colors: [String: Int]) -> (UIColor?, UIColor?, UIColor?) {
        
        var primaryColor: UIColor?, secondaryColor: UIColor?, detailColor: UIColor?
        for (colorString, _) in colors.sorted(by: { $0.value > $1.value }) {
            let colorParts: [String] = colorString.components(separatedBy: ".")
            let color: UIColor = UIColor(red: CGFloat(Int(colorParts[0])!) / 255,
                                         green: CGFloat(Int(colorParts[1])!) / 255,
                                         blue: CGFloat(Int(colorParts[2])!) / 255,
                                         alpha: 1).color(withMinimumSaturation: 0.15)
            
            guard !color.isBlackOrWhite() else { continue }
            if primaryColor == nil {
                primaryColor = color
            } else if secondaryColor == nil {
                if primaryColor!.isDistinct(color) {
                    secondaryColor = color
                }
            } else if detailColor == nil {
                if secondaryColor!.isDistinct(color) && primaryColor!.isDistinct(color) {
                    detailColor = color
                    break
                }
            }
        }
        return (primaryColor, secondaryColor, detailColor)
    }
}

extension UIColor {
    
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
    
    func isDarkColor() -> Bool {
        let luminate: CGFloat = 0.2126 * components.red + 0.7152 * components.green + 0.0722 * components.blue
        if luminate < 0.5 { return true }
        return false
    }
    
    func isDistinct(_ compareColor: UIColor) -> Bool {
        
        let (r, g, b, a) = components
        let (r1, g1, b1, a1) = compareColor.components
        
        let threshold1: CGFloat = 0.25
        guard fabs(r - r1) > threshold1 ||
            fabs(g - g1) > threshold1 ||
            fabs(b - b1) > threshold1 ||
            fabs(a - a1) > threshold1 else { return false }
        
        // check for grays, prevent multiple gray colors
        let threshold2: CGFloat = 0.03
        guard fabs( r - g ) < threshold2 &&
            fabs( r - b ) < threshold2 &&
            fabs(r1 - g1) < threshold2 &&
            fabs(r1 - b1) < threshold2 else { return true }
        
        return false
    }
    
    func color(withMinimumSaturation minSaturation: CGFloat) -> UIColor {
        
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        if saturation < minSaturation {
            return UIColor(hue: hue, saturation: minSaturation, brightness: brightness, alpha: alpha)
        } else {
            return self
        }
    }
    
    func isBlackOrWhite() -> Bool {
        
        let (r, g, b, _) = components
        
        // isWhite
        if r > 0.91 &&
            g > 0.91 &&
            b > 0.91 {
            return true
        }
        
        // isBlack
        if r < 0.09 &&
            g < 0.09 &&
            b < 0.09 {
            return true
        }
        
        return false
    }
    
    func isContrastingColor(_ color: UIColor) -> Bool {
        
        let (r, g, b, _) = components
        let (r2, g2, b2, _) = color.components
        
        let bLum: CGFloat = 0.2126 * r + 0.7152 * g + 0.0722 * b
        let fLum: CGFloat = 0.2126 * r2 + 0.7152 * g2 + 0.0722 * b2
        
        var contrast: CGFloat = 0.0
        if bLum > fLum {
            contrast = (bLum + 0.05) / (fLum + 0.05)
        } else {
            contrast = (fLum + 0.05) / (bLum + 0.05)
        }
        //return contrast > 3.0; //3-4.5 W3C recommends a minimum ratio of 3:1
        return contrast > 1.6
    }
}
