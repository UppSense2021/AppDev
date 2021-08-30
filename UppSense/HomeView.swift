//
//  HomeView.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 05/07/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var bleManager: BLEController
    
    var body: some View {
        VStack {
            VStack {
                Text("Instructions")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                Text("1. Turn on your Bluetooth.\n2. Show the QR code towards the camera of the biosensor to recieve your result.")
                    .multilineTextAlignment(.leading)
            }.padding()
                        
            Image(uiImage: generateQRCode(from: bleManager.peripheralUUID.uuidString))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
    }
}
