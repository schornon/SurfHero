//
//  MenuBarView.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 01.05.2023.
//

import SwiftUI

struct MenuBarView: View {
    
    @StateObject var vm: MenuBarViewModel = .init()
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack(alignment: .leading) {
            let filtered = vm.filteredHttpHandlers
            ForEach(0..<filtered.count, id: \.self) { i in
                let handler = filtered[i]
                let isEnabled = vm.currentHttpHandler.bundleIdentifier != handler.bundleIdentifier
                if let displayName = handler.displayName {
                    Button(displayName) {
                        vm.setDefaultHttpHandler(handler)
                    }
                    .environment(\.isEnabled, isEnabled)
                }
            }
            Divider()
            
            Button("Settings") {
                onSettingsTap()
            }
            
            Button("Quit") {
                vm.onQuitTap()
            }
        }
        .padding(.vertical, 6)
    }
    
    private func onSettingsTap() {
        if !SettingsStore.shared.isOpened {
            openWindow(id: "settings")
        }
        NSApp.activate(ignoringOtherApps: true)
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
    }
}
