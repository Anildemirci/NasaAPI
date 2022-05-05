//
//  DataViewModel.swift
//  AppcentProject
//
//  Created by Anıl Demirci on 3.05.2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine
import SwiftUI

class DataViewModel : ObservableObject {
    
    @Published var photoList = [Photo]()
    @Published var allPhotoList = [Photo]()
    @Published var pagiList=[Photo]()
    @Published var offset: Int = 0
    
    //Alamofire
    
    internal func getData(url: String) {
        
            AF.request(url).responseData { (responseData) in
            
            guard let data = responseData.data else { return }
            do {
                let photos = try JSONDecoder().decode(NasaAPI.self, from: data)
                DispatchQueue.main.async {
                    
                    for i in photos.photos {
                        self.photoList.append(i)
                    }
                }
            } catch {
                print("hata1")
            }
        }
    }
    
    func allPhotos() {
        
        for name in rovers {
            
            AF.request("https://api.nasa.gov/mars-photos/api/v1/rovers/\(name)/photos?sol=1000&api_key=PypebXnYPJ43Gz1ecJwPztuxe8THTFWGMXnp4VnD&page=1").responseData { (responseData) in
            
            guard let data = responseData.data else { return }
            do {
                let photos = try JSONDecoder().decode(NasaAPI.self, from: data)
                DispatchQueue.main.async {
                    
                    for i in photos.photos {
                        self.allPhotoList.append(i)
                    }
                    let sortedPhotos = self.allPhotoList.sorted {
                        $0.id < $1.id
                    }
                    self.allPhotoList=sortedPhotos
                }
            } catch {
                print("hata2")
            }
        }
            
        }
    }
    
    // URLSession
    func fetchData(){
        let url="https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?&sol=1000&api_key=PypebXnYPJ43Gz1ecJwPztuxe8THTFWGMXnp4VnD&page=\(offset)"
        
        let session=URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else {
                print("no data found")
                return
            }
            do {
                let characters = try JSONDecoder().decode(NasaAPI.self, from: APIData)
                DispatchQueue.main.async {
                    self.pagiList.append(contentsOf: characters.photos)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

}

private var rovers = ["curiosity","opportunity","spirit"]

