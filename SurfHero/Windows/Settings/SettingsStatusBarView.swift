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
        VStack {
            Toggle("Browser icon", isOn: $store.statusBarHandlerIcon)
                .toggleStyle(.checkbox)
            
            Toggle("Monochrome", isOn: $store.statusBarHandlerIconMonochrome)
                .toggleStyle(.checkbox)
                .padding(.leading, 42)
                .disabled(!store.statusBarHandlerIcon)
        }
        .frame(width: 300, alignment: .leading)
    }
}

#Preview {
    SettingsStatusBarView()
        .environmentObject(SettingsStore.shared)
}
