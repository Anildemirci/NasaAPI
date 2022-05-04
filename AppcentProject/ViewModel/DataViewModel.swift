//
//  DataViewModel.swift
//  AppcentProject
//
//  Created by Anıl Demirci on 3.05.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataViewModel : ObservableObject {
    @Published var photoList = [Photo]()
    @Published var cameraList = [Camera]()
    @Published var roverList = [Rover]()
    @Published var collectionList = [String]()
    
    func getData(url: String) {
        
        AF.request(url).responseData { (responseData) in
            
            guard let data = responseData.data else { return }
            do {
                let photos = try JSONDecoder().decode(NasaAPI.self, from: data)
                DispatchQueue.main.async {
                    
                    for i in photos.photos {
                        self.photoList.append(i)
                        self.cameraList.append(i.camera)
                        self.roverList.append(i.rover)
                        //self.collectionList.append(i.camera.fullName)
                        
                    }
                }
            } catch {
                print("hata1")
            }
        }
    }
}
