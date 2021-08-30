//
//  ResultsView.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 04/07/21.
//

import SwiftUI
import MapKit

struct ResultsView: View {
    @EnvironmentObject var jsonData: jsonData
    
    // This needs to be static info stored on the device memory
    var body: some View {
        ScrollView {
            Text("Total Results: \(jsonData.jsonArray.count)")
                .font(.title2)
                .multilineTextAlignment(.leading)
            
            ForEach(jsonData.jsonArray) { jsonItem in
                VStack(alignment: .leading) {
                    Text("Result: \(jsonItem.result)")
                    Text("Result Date: \(jsonItem.date)")
                    Text("Result Time: \(jsonItem.time)")
                    Text("Biosensor ID: \(jsonItem.biosensorID)")
                    Text("Test ID: \(jsonItem.testID)")
                    Text("Location: Lattitude [\(jsonItem.coordinates.latitude)], Longitude [\(jsonItem.coordinates.longitude)]")
                    Divider()
                }.padding()
            }
        }
    }
}
