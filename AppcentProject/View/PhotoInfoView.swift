//
//  PhotoInfoView.swift
//  AppcentProject
//
//  Created by Anıl Demirci on 3.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotoInfoView: View {
    
    @Binding var image:String
    @Binding var date:String
    @Binding var roverName:String
    @Binding var camera:String
    @Binding var status:String
    @Binding var landingDate:String
    @Binding var launchDate:String
    
    var body: some View {
        VStack{
            AnimatedImage(url: URL(string: image))
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 0.3)
                .padding()
            Divider()
            Group{
                Text("Date: \(date)")
                Text("Rover Name: \(roverName)")
                Text("Camera: \(camera)")
                Text("Status: \(status)")
                Text("LaunchDate: \(launchDate)")
                Text("LandingDate: \(landingDate)")
            }
            //.scaledToFill()
            .padding()
            .frame(width:UIScreen.main.bounds.width * 1,alignment: .leading)
            Spacer()
        }
    }
}


