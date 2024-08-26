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
        HStack {
            Text(title ?? "").foregroundColor(.white)
        }
    }
}


#Preview {
    FilterView()
}
