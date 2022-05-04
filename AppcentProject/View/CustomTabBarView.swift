//
//  CustomTabBarView.swift
//  AppcentProject
//
//  Created by Anıl Demirci on 3.05.2022.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @State private var selected = ""
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                ForEach(tabs, id:\.self) { tab in
                    Spacer()
                    TabButton(title: tab)
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width * 1, height: 75)
            .background(Color.black.opacity(0.1).ignoresSafeArea(.all,edges: .all))
        }
        
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}

struct TabButton : View {
    
    fileprivate var title : String
    
    var body: some View {
        NavigationLink(destination: RoverView(selectedTab: title)) {
            VStack(spacing:5){
                Spacer(minLength: 5)
                Image(title)
                    .renderingMode(.original)
                    .resizable()
                    //.opacity(selectedTab == title ? 1.0 : 0.5)
                    .clipShape(Circle())
                Text(title)
                    .font(.title3)
                    .foregroundColor(Color.black)
                Spacer(minLength: 5)
            }
        }
    }
}

private var tabs = ["Curiosity","Opportunity","Spirit"]
