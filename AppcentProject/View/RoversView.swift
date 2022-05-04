//
//  RoversView.swift
//  AppcentProject
//
//  Created by Anıl Demirci on 3.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoverView: View {
    
    @ObservedObject var datas=DataViewModel()
    var selectedTab=""
    
    var body: some View {
        VStack {
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    ForEach(datas.photoList) { i in
                        AnimatedImage(url: URL(string: i.imgSrc))
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 0.35)
                            .padding()
                    }
                }
            }
            .navigationTitle(selectedTab)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(cameras, id: \.self) { i in
                            Button(action: {
                                print(i)
                            }) {
                                Text(i)
                            }
                        }
                    } label: {
                    Label(
                        title: {Text("edit")},
                        icon: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .foregroundColor(.black)
                    })
                }
                }
            }
        }.onAppear{
            datas.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(selectedTab)/photos?sol=1000&api_key=PypebXnYPJ43Gz1ecJwPztuxe8THTFWGMXnp4VnD&page=1")
        }
    }
}

var cameras = ["FHAZ","RHAZ","MAST","CHEMCAM","MAHLI","MARDI","NAVCAM","PANCAM"]

