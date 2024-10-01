//
//  SearchModifire.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import SwiftUI

struct SearchModifire: View {
    @Binding var search: String
    
    var body: some View {
        HStack {
            TextField("try Spiderman :)", text: $search)
            Image("SearchIcon")
                .foregroundColor(Color("SearchIconColor"))
        }
        .padding()
        .frame(width: 300, height: 42)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
        )
        .padding(.horizontal)
    }
}

#Preview {
    SearchModifire(search: .constant(""))
}

