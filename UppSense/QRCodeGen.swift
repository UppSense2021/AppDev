//
//  QRCodeGen.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 01/07/21.
//

import Foundation
import CoreImage.CIFilterBuiltins
import SwiftUI

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

func generateQRCode(from string: String) -> UIImage {
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")

    if let outputImage = filter.outputImage {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }
    }

    return UIImage(systemName: "xmark.circle") ?? UIImage()
}
