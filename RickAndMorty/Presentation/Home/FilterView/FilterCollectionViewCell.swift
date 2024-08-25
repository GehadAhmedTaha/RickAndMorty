//
//  FilterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Gehad V on 26/08/2024.
//
import UIKit
import SwiftUI

class FilterCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()

        contentConfiguration = nil
    }
    
    func configure(with data: String, index: Int) {
        self.contentConfiguration =  UIHostingConfiguration {
            FilterView(title: data).padding(
                EdgeInsets(
                    top: 2,
                    leading: 10,
                    bottom: 2,
                    trailing: 10
                )
            )
        
        } .background(.white)
            .margins(.all, 10)
            
    }
 
}

#Preview {
    FilterCollectionViewCell()
}
