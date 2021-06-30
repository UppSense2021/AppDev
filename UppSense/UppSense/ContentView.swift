//
//  ContentView.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 15/06/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bleManager = BLEController()

    var body: some View {
        VStack {
            HStack {
                Image("Uppsense_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Don't distort image while changing size of image
                    .frame(height: 120)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(Color(red: 0.4, green: 0.0, blue: 0.8), lineWidth: 5))
                    .shadow(radius: 5)
                VStack {
                    Text("UppSense")
                        .font(.title)
                    Text("H1N1 Biosensor")
                        .font(.subheadline)
                }
            }.padding()
            
            Spacer()
            
            VStack {
                Text("Date")
                Text("Result")
            }
            
            Spacer()
            
            /* Micellaneous info/Links */
            
            HStack {
                Text("About us")
                Text("Contact us")
                Text("Home")
            }.padding()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity) // Cover the entire area
        .background(Color(red: 0.4, green: 0.0, blue: 0.5)) // Purple
        //.ignoresSafeArea() // Cover the bezels
        .foregroundColor(Color.white) // Make all text white
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
