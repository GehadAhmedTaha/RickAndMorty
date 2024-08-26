//
//  ChracterDetailsView.swift
//  RickAndMorty
//
//  Created by Gehad V on 26/08/2024.
//

import SwiftUI

struct ChracterDetailsView: View {
    let character: Character
    
    var body: some View {
        VStack(alignment: .center,spacing: 10)  {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill).frame(width: 200, height: 200)
                    .cornerRadius(5)
            } placeholder: {
                ProgressView()
            }.fixedSize()
            HStack {
                Spacer()
                Text(character.name).fontWeight(.bold).foregroundColor(.white)
                Spacer().frame(width: 50)
                Text(character.status.rawValue).background(Color.blue).foregroundColor(.white)
                Spacer()
            }

            HStack {
                Text(character.species).foregroundColor(.white)
                Spacer().frame(width: 10)
                Text("●").foregroundColor(.white)
                Spacer().frame(width: 10)
                Text(character.gender.rawValue).foregroundColor(.white)
            }

            HStack {
                Text("Location: ").fontWeight(.semibold).foregroundColor(.white)
                Spacer().frame(width: 10)
                Text(character.location.name).foregroundColor(.white)
            }
            
        }
    }
}

