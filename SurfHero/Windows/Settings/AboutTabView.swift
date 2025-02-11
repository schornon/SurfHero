//
//  AboutTabView.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 22.11.2024.
//

import SwiftUI

struct AboutTabView: View {
    let text: String
    
    var body: some View {
        Text("      " + text)
            .font(.system(size: 12, weight: .regular, design: .rounded))
            .overlay(alignment: .topLeading) {
                Image(systemName: "info.circle")
                    .font(.system(size: 12))
            }
    }
}
