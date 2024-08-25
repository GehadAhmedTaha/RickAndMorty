//
//  FilterView.swift
//  RickAndMorty
//
//  Created by Gehad V on 26/08/2024.
//

import SwiftUI

struct FilterView: View {
    
    var title: String?
    
    var body: some View {
            Text(title ?? "")
                .overlay(
                RoundedRectangle(cornerRadius: 20, style: RoundedCornerStyle.continuous)
                    .stroke(.black, lineWidth: 1)
                    .frame(width: 80, height: 30)
                    
            )
      
    }
}
/*
 .padding([.trailing], 8)
               .padding([.top, .bottom], 8)
 */

#Preview {
    FilterView()
}
