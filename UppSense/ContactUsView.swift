//
//  ContactUsView.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 04/07/21.
//

import SwiftUI

struct ContactUsView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Our Coordinators")
                    .font(.title)

                Image("gemma")
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Don't distort image while changing size of image
                    .frame(height: 200)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(Color(red: 0.4, green: 0.0, blue: 0.8), lineWidth: 5))
                    .shadow(radius: 5)
                
                Divider()
                
                Text("Gemma Mestres")
                    .font(.title2)
                Text("Associate Senior Lecturer, PhD, docent")
                    .font(.footnote)
                
                Divider()
                
                Text("Gemma Mestres has been coach of the Uppsala University team from the first edition in 2015-2016. She belongs to the Microsystems Technology Division of the Technological and Natural Sciences faculty. Her background is on the development and biological characterization of biomaterials for bone tissue regeneration. Right now she is aiming to use her knowledge on biomaterials, in vitro studies and microfluidics to create a new microfluidic device that will allow to study the biological properties of biomaterials aimed for bone regeneration.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Image("masood")
                .resizable()
                .aspectRatio(contentMode: .fit) // Don't distort image while changing size of image
                .frame(height: 200)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color(red: 0.4, green: 0.0, blue: 0.8), lineWidth: 5))
                .shadow(radius: 5)
            
            Divider()
            
            Text("Masood Kamali-Moghaddam")
                .font(.title2)
            Text("Senior Lecturer")
                .font(.footnote)
            
            Divider()
            
            Text("Masood Kamali-Moghaddam received his PhD in Pharmaceutical Microbiology at Dept. of Pharmaceutical Biosciences at Uppsala University where he studied bacterial genetics and the importance of transposition and site-specific recombination in the dissemination of antibiotic resistance. He held a post-doctoral position at Center for Molecular Genetics at the University of California, San Diego, where he studied transcription initiation and regulation. He held a second post-doctoral position at Dept. Of Genetics and Pathology/ Div. of Molecular Tools at Uppsala University. Here he worked with the development and application of sensitive molecular tools for proteome analyses. Currently, he works as Associate Professor in Molecular Diagnostics at the same department and continues working on the development of highly sensitive molecular tools for the search for protein and exosome biomarkers and early diagnostics.")
                .multilineTextAlignment(.center)
                .padding()
        }
        
        Divider()
        
        VStack(alignment: .leading) {
            Text("Contact Info")
                .font(.title3)
            HStack {
                Button {
                    openURL(URL(string: "https://sensusuppsala.com")!)
                } label: {
                    HStack {
                        Text("Website")
                            .fontWeight(.medium)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 0.4, green: 0.0, blue: 0.8))
                    .cornerRadius(5)
                }
                Spacer()
                Button {
                    openURL(URL(string: "https://www.facebook.com/UppsalaSensUs")!)
                } label: {
                    HStack {
                        Text("Facebook")
                            .fontWeight(.medium)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 0.4, green: 0.0, blue: 0.8))
                    .cornerRadius(5)
                }
                Spacer()
                Button {
                    openURL(URL(string: "https://www.instagram.com/uppsalasensus")!)
                } label: {
                    HStack {
                        Text("Instagram")
                            .fontWeight(.regular)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 0.4, green: 0.0, blue: 0.8))
                    .cornerRadius(5)
                }
                /*
                Link("Facebook", destination: URL(string: "https://www.facebook.com/UppsalaSensUs")!)
                Link("Instagram", destination: URL(string: "https://www.instagram.com/uppsalasensus")!)
                Link("Website", destination: URL(string: "https://sensusuppsala.com")!)
                */
            }
            Text("Email: uppsala.sensus@gmail.com or \nGemma.Mestres@angstrom.uu.se")
        }.padding()
    }
}
