//
//  ContentView.swift
//  AppcentProject
//
//  Created by Anıl Demirci on 3.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct HomeView: View {
    
    @ObservedObject private var datas=DataViewModel()
    @State private var selected="grid"
    
    var body: some View {
        NavigationView {
                VStack{
                    HStack{
                        Button(action: {
                            selected="row"
                        }) {
                            Image(systemName: "rectangle.grid.1x2")
                                .foregroundColor(selected=="row" ? Color.black : Color.black.opacity(0.4))
                        }
                        Button(action: {
                            selected="grid"
                        }) {
                            Image(systemName: "square.grid.2x2")
                                .foregroundColor(selected=="grid" ? Color.black : Color.black.opacity(0.4))
                        }
                    }
                    Spacer(minLength: 15)
                    ScrollView(.vertical, showsIndicators: false){
                        if selected=="grid" {
                            GridView()
                        } else {
                            RowView()
                        }
                        
                    }.frame(height: UIScreen.main.bounds.height * 0.7)
                    CustomTabBarView()
                }
                .navigationTitle("Nasa API")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct GridView: View {
    
    @ObservedObject private var datas=DataViewModel()
    @State private var showingPopover = false
    @State private var image=""
    @State private var date=""
    @State private var roverName=""
    @State private var camera=""
    @State private var status=""
    @State private var landingDate=""
    @State private var launchDate=""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(datas.allPhotoList){i in
                            VStack{
                                AnimatedImage(url: URL(string: i.imgSrc))
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.3)
                                    .cornerRadius(20)
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
        }.onAppear{
            datas.allPhotos()
        }
        .popover(isPresented: $showingPopover) { () -> PhotoInfoView in
            PhotoInfoView(image: $image, date: $date, roverName: $roverName, camera: $camera, status: $status, landingDate: $landingDate, launchDate: $launchDate)
        }
    }
}

struct RowView: View {
    
    @ObservedObject private var datas=DataViewModel()
    @State private var showingPopover = false
    @State private var image=""
    @State private var date=""
    @State private var roverName=""
    @State private var camera=""
    @State private var status=""
    @State private var landingDate=""
    @State private var launchDate=""
    
    var body: some View {
        VStack {
            ForEach(datas.allPhotoList){i in
                VStack{
                    AnimatedImage(url: URL(string: i.imgSrc))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
                        .cornerRadius(20)
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
        }.onAppear{
            datas.allPhotos()
        }
        .popover(isPresented: $showingPopover) { () -> PhotoInfoView in
            PhotoInfoView(image: $image, date: $date, roverName: $roverName, camera: $camera, status: $status, landingDate: $landingDate, launchDate: $launchDate)
        }
    }
}



