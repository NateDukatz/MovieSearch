//
//  MovieListTableViewController.swift
//  Movies
//
//  Created by Nate Dukatz on 8/8/17.
//  Copyright © 2017 NateDukatz. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate { //, MovieControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!


    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        MovieController.shared.search(search: text) { (movies) in
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MovieController.shared.movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }
        
        let movie = MovieController.shared.movies[indexPath.row]
        cell.update(withMovie: movie)
        
        return cell
    }

}
