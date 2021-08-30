//
//  resultsJSONModel .swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 08/07/21.
//

import Foundation
import CoreLocation

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}

struct resultsJSONModel: Hashable, Codable, Identifiable {
    var id: Int
    var result: String
    var biosensorID: String
    var testID: String
    var date: String
    var time: String
    
    var coordinates: Coordinates

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
}

extension Bundle {
    static func load<T: Decodable>(_ filename: String) -> T {

        let readURL = Bundle.main.url(forResource: filename, withExtension: "json")! //Example json file in our bundle
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! // Initializing the url for the location where we store our data in filemanager

        let jsonURL = documentDirectory // appending the file name to the url
            .appendingPathComponent(filename)
            .appendingPathExtension("json")

        // The following condition copies the example file in our bundle to the correct location if it isnt present
        if !FileManager.default.fileExists(atPath: jsonURL.path) {
            try? FileManager.default.copyItem(at: readURL, to: jsonURL)
        }

        // returning the parsed data
        return try! JSONDecoder().decode(T.self, from: Data(contentsOf: jsonURL))
    }
}

class jsonData: ObservableObject {
    @Published var jsonArray : [resultsJSONModel] // The Published wrapper marks this value as a source of truth for the view

    init() {
        self.jsonArray = Bundle.load("results_2") // Initailizing the array from a json file
    }

    // function to write the json data into the file manager
    func writeJSON() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let jsonURL = documentDirectory
            .appendingPathComponent("list")
            .appendingPathExtension("json")
        try? JSONEncoder().encode(jsonArray).write(to: jsonURL, options: .atomic)
    }
}
