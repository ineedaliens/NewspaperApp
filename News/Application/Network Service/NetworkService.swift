//
//  NetworkService.swift
//  News
//
//  Created by Евгений on 07.03.2021.
//

import UIKit

class NetworkService {
    
   static func fetchData(url: String, completion: @escaping (_ newsdata: News)->()) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, responce, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let newsdata = try decoder.decode(News.self, from: data)
                print(newsdata)
                completion(newsdata)
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    static func downloadImage(url: String, indexPath: IndexPath, completion: @escaping (_ image: UIImage)->()) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, responce, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
        .resume()
    }
}
