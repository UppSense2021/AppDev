//
//  ContentView.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 15/06/21.
//

import SwiftUI
import CoreLocation
import MapKit

enum bottomButtonType {
    case home, aboutUs, contactUs, results
}

struct ContentView: View {
    @StateObject private var JsonData = jsonData() //Results JSON
    @ObservedObject var bleManager = BLEController()
    @State var currentPage = bottomButtonType.home // Init to land in homepage
    @ObservedObject private var locationManager = LocationManager()

    var body: some View {
        // logo and title
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
            }.padding(.top, 50)
            
            Divider()
            
            // Current page to be dislayed in the middle
            switch currentPage {
            case .home:
                HomeView(bleManager: bleManager)
                
            case .aboutUs:
                AboutUsView()
                
            case .contactUs:
                ContactUsView()
                
            case .results:
                ResultsView().environmentObject(JsonData)
            }
            
            
            Spacer()
            
            /*
            Button("Test") {
                bleManager.currentResultMsg = resultMsg(result: "Positive", biosensorID: "98XA", testID: "1782", date: "7th September 2021", time: "12:14 CET")
                
                bleManager.showAlert = true
                ble_in_test()
            } */
            
            Divider()
            
            
            // Bottom horizontal menu
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "house.fill")
                    Button("Home") {
                        currentPage = bottomButtonType.home
                    }
                }
                Spacer()
                VStack {
                    Image(systemName: "person.3.fill")
                    Button("About us") {
                        currentPage = bottomButtonType.aboutUs
                    }
                }
                Spacer()
                VStack {
                    Image(systemName: "phone.fill")
                    Button("Contact us") {
                        currentPage = bottomButtonType.contactUs
                    }
                }
                Spacer()
                VStack {
                    Image(systemName: "cross.case.fill")
                    Button("Results") {
                        currentPage = bottomButtonType.results
                    }
                }
                Spacer()
            }.padding()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity) // Cover the entire area
        .background(Color(red: 0.4, green: 0.0, blue: 0.5)) // Purple
        .ignoresSafeArea() // Cover the bezels
        .foregroundColor(Color.white) // Make all text white
        .alert(isPresented: $bleManager.showAlert) { () -> Alert in
            
            let coordinate = self.locationManager.location != nil ?
                self.locationManager.location!.coordinate : CLLocationCoordinate2D()
            
            var placemark: String { return("\(locationManager.placemark?.name ?? ""), \(locationManager.placemark?.subLocality ?? ""), \(locationManager.placemark?.locality ?? ""), \(locationManager.placemark?.country ?? "")") }
            
            let primaryButton = Alert.Button.default(Text("Yes")) {
                bleManager.showAlert = false
                print("Yes")
                // Save new reult
                JsonData.jsonArray.append(resultsJSONModel(id: (JsonData.jsonArray.count + 1),
                                                           result: bleManager.currentResultMsg.result,
                                                           biosensorID: bleManager.currentResultMsg.biosensorID,
                                                           testID: bleManager.currentResultMsg.testID,
                                                           date: bleManager.currentResultMsg.date,
                                                           time: bleManager.currentResultMsg.time,
                                                           coordinates: Coordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)))
                JsonData.writeJSON()
            }
            let secondaryButton = Alert.Button.cancel(Text("No")) {
                bleManager.showAlert = false
                print("No")
                // If you want to change specific info based on "no", remove fields here. 
                JsonData.jsonArray.append(resultsJSONModel(id: (JsonData.jsonArray.count + 1),
                                                           result: bleManager.currentResultMsg.result,
                                                           biosensorID: bleManager.currentResultMsg.biosensorID,
                                                           testID: bleManager.currentResultMsg.testID,
                                                           date: bleManager.currentResultMsg.date,
                                                           time: bleManager.currentResultMsg.time,
                                                           coordinates: Coordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)))
                JsonData.writeJSON()
            }
            
            return Alert(title: Text("New result recieved"),
                         message: Text("Result: \(bleManager.currentResultMsg.result)\nDate: \(bleManager.currentResultMsg.date)\nTime: \(bleManager.currentResultMsg.time)\nBiosensor ID: \(bleManager.currentResultMsg.biosensorID)\nTest ID: \(bleManager.currentResultMsg.testID)\nLocation name: \(placemark)\n\nDo you consent for this data to be used by health organiazations to better track the spread of the virus?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


