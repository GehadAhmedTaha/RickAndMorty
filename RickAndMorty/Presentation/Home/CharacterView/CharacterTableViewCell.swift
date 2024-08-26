//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Gehad V on 26/08/2024.
//

import SwiftUI

class CharacterTableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentConfiguration = nil
    }
    
    func configure(with data: Character) {
        self.contentConfiguration =  UIHostingConfiguration {
            CharacterView(character: data)
            
        }.background(Constants.backgroundColor)
    }
}
#Preview {
    CharacterTableViewCell()
}
