//
//  CharactersViewController.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var characterContentBuilder = CharacterContentBuilder()
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "My Title"
    }
    
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: Constants.shared.characterCell, bundle: .main),
                                forCellWithReuseIdentifier: Constants.shared.characterCell)
        
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
    
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: view.frame.height / 3)
    }
}
