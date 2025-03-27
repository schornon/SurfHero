//
//  SettingsAboutView.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 22.11.2024.
//

import SwiftUI

struct SettingsAboutView: View {
    @EnvironmentObject var store: SettingsStore
    @Environment(\.openURL) var openURL
    private let supportURL = URL(string: "https://schornon.github.io/the-surf-hero/support.html")
    
    var body: some View {
        VStack {
            Color.clear
                .frame(width: 250, height: 210)
                .overlay {
                    Image(.surfHeroAppIcon)
                        .resizable()
                        .frame(width: 250, height: 250)
                }
            
            VStack(spacing: 2) {
                Text("The Surf Hero")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                
                Text(store.appVersion)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .opacity(0.4)
                
                Text("Copyright © 2025 Serhii Chornonoh")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .opacity(0.4)
            }
            
            
            HStack {
                Button("Support") {
                    if let supportURL {
                        openURL(supportURL)
                    }
                }
            }
            .padding(.top, 6)
        }
    }
}

#Preview {
    SettingsAboutView()
        .environmentObject(SettingsStore.shared)
}
