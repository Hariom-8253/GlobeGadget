//
//  URL Session.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 23/07/25.
//

import Foundation
class APICalls{
    
    class func getData<Type: Codable>(from urlstring:String, completion: @escaping([Type]) -> Void){
        guard let url = URL(string: urlstring) else{
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(request)
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            if error == nil {
                guard let data = data else {return}
                do{
                    let decode = try JSONDecoder().decode([Type].self, from: data)
                    completion(decode)
                }catch{
                    print(error)
                }
                
            }
        }
        task.resume()
    }
}

extension String {
    /// Returns a percent-encoded string that's safe to use in URL queries.
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
