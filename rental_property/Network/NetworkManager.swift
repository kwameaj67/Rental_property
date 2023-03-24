//
//  NetworkManager.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/23/23.
//

import Foundation


enum NetworkError: Error{
    case badData
    case badURL
}

class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init(){ }
    
    
    func readFile(from fileName: String?) -> Data? { // pass file name to get resource that match in our main bundle
       do {
           if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
              let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8){
               return jsonData
           }
       }
       catch(let error) {
           print("DEBUG: \(error.localizedDescription)")
       }
       return nil
   }
    
    func fetchLocation(completion: @escaping ([PropertyLocation]?, Error?) -> Void){
        let data = readFile(from: "locations")
        
        guard let data = data else {
            completion(nil, NetworkError.badData)
            return
        }
        
        do{
            let results = try JSONDecoder().decode([PropertyLocation].self,from: data)
            completion(results, nil)
        }
        catch(let err)
        {
            print("Error:\(err.localizedDescription)")
            completion(nil,err)
        }
    }
    
    func fetchPropertyDetail(property_id: Int, completion: @escaping (PropertyDetail?, Error?) -> Void){
        let data = readFile(from: "property-detail")
        
        guard let data = data else { return }
        
        do{
            let results = try JSONDecoder().decode([PropertyDetail].self,from: data)
            _ = results.map { item in
                if (item.location_id == property_id){
                    completion(item,nil)
                }
            }
            completion(nil, nil)
        }
        catch(let err)
        {
            completion(nil,err)
        }
    }
}
