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
    private let supportURL = URL(string: "https://forms.gle/Xm2RoiMLxWmeQhpP6")
    
    var body: some View {
        VStack {
            Image(.surfHeroAppIcon)
                .resizable()
                .frame(width: 250, height: 250)
            
            VStack {
                Text("Surf Hero")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                
                Text(store.appVersion)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .opacity(0.4)
                
                Text("Copyright © 2024 Serhii Chornonoh")
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
