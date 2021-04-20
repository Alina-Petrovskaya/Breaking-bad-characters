//
//  FavouritesViewController.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var selectedItemIndex: Int?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.shared.fromFavouritesToDetail,
           let safeIndex    = selectedItemIndex {
            
            let char         = FavouritesContentManager.shared.arrayOfCharacters[safeIndex]
            let image        = UIImage(data: char.image)
            
            if let image = image {
                weak var vc = segue.destination as? DetailViewController
                
                vc?.charakterInformation = (id: char.id,
                                            image: image,
                                            name: char.name,
                                            nickName: char.nickName,
                                            birth: char.birth,
                                            occupation: char.occupation,
                                            appearance: char.appearance,
                                            portrayed: char.portrayed)
                vc?.callBack = { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
}


// MARK: - UITableViewDataSource
extension FavouritesViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let chatacterID = FavouritesContentManager.shared.arrayOfCharacters[indexPath.row].id
            FavouritesContentManager.shared.deleteItem(character: chatacterID)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.shared.fromFavouritesToDetail, sender: self)
    }
}
