//
//  DetailViewController.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit

typealias CharacterInformation = (id: Int, image: UIImage, name: String, nickName: String, birth: String, occupation: [String], appearance: [String], portrayed: String)

class DetailViewController: UIViewController {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDescription: UITextView!
    var charakterInformation: CharacterInformation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    @IBAction func addToFavouritesTapped(_ sender: UIBarButtonItem) {
    }
    

}
