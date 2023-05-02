//
//  SettingsView.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 01.05.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var store: SettingsStore
    
    var body: some View {
        Text("Settings")
            .onAppear {
                store.isOpened = true
            }
            .onDisappear {
                store.isOpened = false
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
