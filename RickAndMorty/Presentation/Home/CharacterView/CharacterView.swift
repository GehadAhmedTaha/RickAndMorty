//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Gehad V on 26/08/2024.
//

import SwiftUI

struct CharacterView: View {
    
   var character: Character
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }.frame(width: 80, height: 80)
            
            VStack(alignment: .leading) {
                Text(character.name).fontWeight(.bold).foregroundColor(.white)
                Text(character.species).foregroundColor(.white)
            }.padding()
            Spacer()
        }.frame(maxWidth: .infinity)
            .background(Constants.characterViewBackgroundColor)
            .cornerRadius(10)
                
    }
}

