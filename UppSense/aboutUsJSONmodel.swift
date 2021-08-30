//
//  aboutUsJSONmodel.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 05/07/21.
//

import Foundation
import Combine
import SwiftUI

struct teamMember: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var imageName: String
    var image: Image {
        Image(imageName)
    }
}

final class ModelData: ObservableObject {
    /* A variable can be outside a structure. so struct was like a class in C++
     and this variable is an array. Here we load the Json. So cool that the JSON can be a separate file and we can extract data from it */
    @Published var teamMembers: [teamMember] = load("teamMembersInfo.json") //This is ho you give an nput
}


/* What does the load function do- load json
protocol - codable  */
func load<T: Decodable>(_ filename: String) -> T { //This is how you define an input parameter
    let data: Data //What does the let keyword do?

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    /* Catch exceptions - Exception handling */
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
