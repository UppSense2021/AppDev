//
//  AboutUsView.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 04/07/21.
//

import SwiftUI

struct AboutUsView: View {
    @ObservedObject var teamMembers = ModelData()
    
    var body: some View {
        ScrollView {
            VStack {
                Image("team")
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Don't distort image while changing size of image
                    .frame(height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(Color(red: 0.4, green: 0.0, blue: 0.8), lineWidth: 5))
                    .shadow(radius: 5)
                
                Text("\nUppsense is a very diverse group of 15 individuals from many different nationalities and backgrounds, coming together to build a biosensor to help create a better future.\n\nAs master students at Uppsala University, our goal within the competition is to get out of our comfort zones, learn something new, and develop unique and creative ideas for biosensors. We are motivated to lay the foundations of a cheap, fast, reliable, and most importantly accessible biosensor as a detection tool in this project. Through the use of our combined wits, knowledge, and experience within a large variety of fields, we hope to continue to research developments into not only influenza, but other pandemic-causing viruses such as COVID-19. This experience provides an opportunity not only to develop something amazing, but to continue our research into our respective fields. We will carry forward the lessons learnt from tackling large scale problems as a global team effort. We hope to raise awareness that everyone can contribute with their different areas of expertise in these crises.\n\nWith lots of passion, enthusiasm, and a strong morale, we will enjoy this journey with you to battle influenza A. We can’t wait to meet you in Eindhoven!\n")
                    .multilineTextAlignment(.center)
                
                Text("Meet the UppSense 2021 team")
                    .font(.title)
                
                ForEach(teamMembers.teamMembers) { teamMember in
                    VStack {
                        Image(teamMember.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit) // Don't distort image while changing size of image
                            .frame(height: 200)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay(Circle().stroke(Color(red: 0.4, green: 0.0, blue: 0.8), lineWidth: 5))
                            .shadow(radius: 5)
                        Divider()
                        Text(teamMember.name)
                            .font(.title)
                        Divider()
                        Text(teamMember.description)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }.padding()
        }
    }
}

