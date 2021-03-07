//
//  NetworkService.swift
//  News
//
//  Created by Евгений on 07.03.2021.
//

import Foundation

class NetworkService {
    
    var newsdata: Array<Dictionary<String, Any>>?
    var newsDataHandler: ((Array<Dictionary<String, Any>>?) -> Void?)!
    
    func fetchData() {
        let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, responce, error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                let results = json["results"] as! Array<Dictionary<String, Any>>
                self.newsdata = results
                self.newsDataHandler?(self.newsdata)
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
