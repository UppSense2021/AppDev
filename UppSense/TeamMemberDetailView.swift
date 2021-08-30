//
//  TeamMemberDetailView.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 05/07/21.
//

import SwiftUI

struct TeamMemberDetailView: View {
    var teamMember: teamMember
    
    var body: some View {
        ScrollView {
            VStack {
                Image(teamMember.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Don't distort image while changing size of image
                    .frame(height: 80)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(Color(red: 0.4, green: 0.0, blue: 0.8), lineWidth: 5))
                    .shadow(radius: 5)
                Divider()
                Text(teamMember.name)
                    .font(.title)
                Divider()
                Text(teamMember.description)
                    .padding()
            }
        }
    }
}
