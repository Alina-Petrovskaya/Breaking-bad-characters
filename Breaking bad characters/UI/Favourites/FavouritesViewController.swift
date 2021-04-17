//
//  FavouritesViewController.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    private func prepareUI() {
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.shared.favouritesCell, bundle: .main),
                           forCellReuseIdentifier: Constants.shared.favouritesCell)
    }
}


extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavouritesContentManager.shared.arrayOfCharacters.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.favouritesCell, for: indexPath) as? FavouritesTableViewCell
        
        let characterItem = FavouritesContentManager.shared.arrayOfCharacters[indexPath.row]
        cell?.updateUI(image: characterItem.image, name: characterItem.name)
        
        return cell ?? UITableViewCell()
    }
}

extension FavouritesViewController: UITableViewDelegate {
    
}


