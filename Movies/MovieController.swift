//
//  MovieController.swift
//  Movies
//
//  Created by Nate Dukatz on 8/6/17.
//  Copyright © 2017 NateDukatz. All rights reserved.
//

import UIKit

class MovieController {

    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static let movieURL = "https://image.tmdb.org/t/p/w500"
    
    static let shared = MovieController()
    
    var movies = [Movie]()

    
    //weak var delegate: MovieControllerDelegate?

    func search(search: String, completion: @escaping (([Movie]) -> Void)) {
        
        guard let url = MovieController.baseURL else { fatalError() }
    
        let urlParameters = ["api_key" : "c695ff07f59d04bfaccdbaebef0f061f", "language" : "en-US", "query" : search]
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            
            guard let data = data, let dataResponseString = String(data: data, encoding: .utf8) else { return }
            
            guard let responseDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String : Any],
                let movieDictionaries = responseDictionary["results"] as? [[String : Any]] else {
                    NSLog("\(dataResponseString)")
                    completion([])
                    return
            }
            
            let movies = movieDictionaries.flatMap{ Movie(dictionary: $0) }
            
            DispatchQueue.main.async {
                self.movies = movies
                completion(movies)
            }
        }
    }
}


extension MovieController {

    func getImage(imagePathExtension: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: MovieController.movieURL + imagePathExtension) else { fatalError() }
        
        NetworkController.performRequest(for: url, httpMethod: .Get) { (data, error) in
            
            guard let data = data, let image = UIImage(data: data) else { fatalError() }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
}
