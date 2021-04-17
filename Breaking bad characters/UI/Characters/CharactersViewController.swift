//
//  CharactersViewController.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit
import SDWebImage

class CharactersViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var characterContentBuilder = CharacterContentBuilder()
    private var selectedItemIndex: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCollectionView()
        characterContentBuilder.getAllCharacters()
        
        characterContentBuilder.callBack = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        characterContentBuilder.errorAlert = { [weak self] error in
            self?.errorAlertShow(with: error)
        }
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: Constants.shared.characterCell, bundle: .main),
                                forCellWithReuseIdentifier: Constants.shared.characterCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.shared.fromCharactersToDetail,
           let safeIndex    = selectedItemIndex,
           let char         = characterContentBuilder.characters?[safeIndex] {
            
            let imageView = UIImageView()
            imageView.sd_setImage(with: URL(string: char.img))
            
            if let image = imageView.image {
                weak var vc = segue.destination as? DetailViewController
                
                vc?.charakterInformation = (id: char.char_id,
                                            image: image,
                                            name: char.name,
                                            nickName: char.nickname,
                                            birth: char.birthday,
                                            occupation: char.occupation,
                                            appearance: char.appearance,
                                            portrayed: char.portrayed)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterContentBuilder.characters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.characterCell, for: indexPath) as? CharacterCollectionViewCell
        
        return characterContentBuilder.buildCellContent(for: indexPath.row, cell: cell)
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension CharactersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
        performSegue(withIdentifier: Constants.shared.fromCharactersToDetail, sender: self)
    }
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: view.frame.height / 3)
    }
}
