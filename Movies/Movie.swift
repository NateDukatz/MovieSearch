//
//  Movie.swift
//  Movies
//
//  Created by Nate Dukatz on 8/6/17.
//  Copyright © 2017 NateDukatz. All rights reserved.
//

import Foundation


struct Movie {
    
    fileprivate let titleKey = "title"
    fileprivate let imageKey = "poster_path"
    fileprivate let summaryKey = "overview"
    fileprivate let ratingKey = "vote_average"
    
    let title: String
    let imagePath: String
    let summary: String
    let rating: Double
}

extension Movie {
    
    init?(dictionary: [String : Any]) {
        
        guard let title = dictionary[titleKey] as? String,
            let imagePath = dictionary[imageKey] as? String,
            let summary = dictionary[summaryKey] as? String,
            let rating = dictionary[ratingKey] as? Double else { return nil }
            
        
        self.title = title
        self.imagePath = imagePath
        self.summary = summary
        self.rating = rating
    }
}
