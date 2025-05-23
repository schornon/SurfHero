//
//  SettingsStatusBarView.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 05.06.2024.
//

import SwiftUI

struct SettingsStatusBarView: View {
    @EnvironmentObject var store: SettingsStore
    
    var body: some View {
        VStack(alignment: .leading) {
            AboutTabView(text: "Customize the appearance of the status bar icon")
                .frame(width: 240)
                .fixedSize()
            
            VStack(alignment: .leading) {
                Toggle("Browser icon", isOn: $store.statusBarHandlerIcon)
                    .toggleStyle(.checkbox)
                
                Toggle("Monochrome", isOn: $store.statusBarHandlerIconMonochrome)
                    .toggleStyle(.checkbox)
                    .padding(.leading, 20)
                    .disabled(!store.statusBarHandlerIcon)
            }
        }
    }
}

#Preview {
    SettingsStatusBarView()
        .environmentObject(SettingsStore.shared)
        .padding()
        .frame(width: 300)
}
