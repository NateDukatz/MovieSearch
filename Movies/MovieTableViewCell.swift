//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Nate Dukatz on 8/8/17.
//  Copyright © 2017 NateDukatz. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        titleLabel.text = ""
        ratingLabel.text = ""
        summaryLabel.text = ""
    }
    

}

extension MovieTableViewCell {
    
    func update(withMovie movie: Movie) {
        
        self.titleLabel.text = movie.title
        self.ratingLabel.text = "Rating: \(movie.rating)"
        self.summaryLabel.text = movie.summary
        
        MovieController.shared.getImage(imagePathExtension: movie.imagePath) { (image) in
            
            guard let image = image else { return }
            
            self.movieImageView.image = image
        }
        
    }
}
