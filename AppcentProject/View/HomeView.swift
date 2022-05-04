//
//  ContentView.swift
//  AppcentProject
//
//  Created by Anıl Demirci on 3.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct HomeView: View {
    @ObservedObject var datas=DataViewModel()
    
    var body: some View {
        NavigationView {
                VStack{
                    Spacer(minLength: 25)
                    CollectionView()
                    Spacer()
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

struct CollectionView: View {
    
    @ObservedObject var datas=DataViewModel()
    @State var showingPopover = false
    @State var image=""
    @State var date=""
    @State var roverName=""
    @State var camera=""
    @State var status=""
    @State var landingDate=""
    @State var launchDate=""
    
    let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=PypebXnYPJ43Gz1ecJwPztuxe8THTFWGMXnp4VnD&page=1"
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(datas.photoList) { i in
                    AnimatedImage(url: URL(string: i.imgSrc))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4)
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
        .onAppear{
            datas.getData(url: url)
        }
        .popover(isPresented: $showingPopover) { () -> PhotoInfoView in
            PhotoInfoView(image: $image, date: $date, roverName: $roverName, camera: $camera, status: $status, landingDate: $landingDate, launchDate: $launchDate)
        }
    }
}





