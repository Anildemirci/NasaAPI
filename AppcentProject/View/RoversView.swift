//
//  RoversView.swift
//  AppcentProject
//
//  Created by Anıl Demirci on 3.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoverView: View {
    
    @ObservedObject private var datas=DataViewModel()
    var selectedTab=""
    @State private var showingPopover = false
    @State private var image=""
    @State private var date=""
    @State private var roverName=""
    @State private var camera=""
    @State private var status=""
    @State private var landingDate=""
    @State private var launchDate=""
    @State private var filter=""
    
    var body: some View {
        VStack {
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    ForEach(filter == "" ? datas.photoList : datas.photoList.filter{$0.camera.name.contains(filter)}) { i in
                        AnimatedImage(url: URL(string: i.imgSrc))
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 0.35)
                            .padding()
                            .onTapGesture {
                                image=i.imgSrc
                                date=i.earthDate
                                roverName=i.rover.name
                                camera=i.camera.fullName
                                status=i.rover.status
                                landingDate=i.rover.landingDate
                                launchDate=i.rover.launchDate
                                showingPopover.toggle()
                            }
                    }
                }
            }
            .navigationTitle(selectedTab)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(cameras, id: \.self) { i in
                            Button(action: {
                                filter=i
                            }) {
                                Text(i)
                            }
                        }
                        Button(action: {
                            filter=""
                        }) {
                            Text("Hepsi")
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
        }
        .onAppear{
            datas.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(selectedTab)/photos?sol=1000&api_key=8EgsUMXA8B68dbAIaevGEfocEWOiwEf0pSW38hEe&page=1")
        }
        .popover(isPresented: $showingPopover) { () -> PhotoInfoView in
            PhotoInfoView(image: $image, date: $date, roverName: $roverName, camera: $camera, status: $status, landingDate: $landingDate, launchDate: $launchDate)
        }
    }
}

private var cameras = ["FHAZ","RHAZ","MAST","CHEMCAM","MAHLI","MARDI","NAVCAM","PANCAM"]

