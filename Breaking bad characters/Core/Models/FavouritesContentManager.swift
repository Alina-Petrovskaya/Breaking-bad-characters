//
//  FavouritesContentManager.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import Foundation

class FavouritesContentManager {
    
    static let shared = FavouritesContentManager()
    
    var arrayOfCharacters: [FavouritesContentManagerModel] = []
    
    func saveItem(item: FavouritesContentManagerModel) {
        arrayOfCharacters.append(item)
        saveModel()
    }
    
    func deleteItem(character id: Int?) {
         guard let safeID = id else { return }
         
        let index = FavouritesContentManager.shared.arrayOfCharacters.firstIndex { (character) -> Bool in
            return character.id == safeID
        }
        
        if let safeIndex = index {
            FavouritesContentManager.shared.arrayOfCharacters.remove(at: safeIndex)
            FavouritesContentManager.shared.saveModel()
        }
     }
    
    
    func loadImageItems() {
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("favourutes.plist")
        
        guard let dataFile = dataFilePath else { return }
        
        if let data = try? Data(contentsOf: dataFile) {
            
            let decoder = PropertyListDecoder()
            do {
                let imageData = try decoder.decode([FavouritesContentManagerModel].self, from: data)
                arrayOfCharacters = imageData
                
            } catch {
                print("Error at reading data: \(error.localizedDescription)")
            }
        }}
    
    
    private func saveModel() {
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("favourutes.plist")
        
        guard let dataFile = dataFilePath else { return }
        
        let encoder  = PropertyListEncoder()
        do {
            let data = try encoder.encode(arrayOfCharacters)
            try data.write(to: dataFile)
            
        } catch {
            print("Can't save data into FileManager")
        }

    }
}
