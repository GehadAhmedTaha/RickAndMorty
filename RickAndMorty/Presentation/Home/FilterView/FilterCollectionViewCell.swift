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
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.backgroundColor = UIColor(.yellow)
            } else {
                self.backgroundColor =  UIColor(Constants.characterViewBackgroundColor)
            }
        }
    }
    
    func configure(with data: String, index: Int) {
        self.contentConfiguration =  UIHostingConfiguration {
            HStack {
                Spacer().frame(width: 10)
                FilterView(title: data)
                Spacer().frame(width: 10)
            }            
        }.background(Constants.characterViewBackgroundColor)
            
    }
}

#Preview {
    FilterCollectionViewCell()
}
