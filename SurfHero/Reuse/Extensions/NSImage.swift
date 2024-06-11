//
//  NSImage.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 05.06.2024.
//

import AppKit
import CoreImage

extension NSImage {
    func monochrome() -> NSImage? {
        guard let ciImage = self.ciImage else { return nil }
        
        let filter = CIFilter(name: "CIColorControls")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(0.0, forKey: kCIInputSaturationKey)
        
        guard let outputCIImage = filter.outputImage else { return nil }
        
        let rep = NSCIImageRep(ciImage: outputCIImage)
        let nsImage = NSImage(size: self.size)
        nsImage.addRepresentation(rep)
        
        return nsImage
    }
    
    var ciImage: CIImage? {
        guard let imageData = self.tiffRepresentation else { return nil }
        return CIImage(data: imageData)
    }
}
