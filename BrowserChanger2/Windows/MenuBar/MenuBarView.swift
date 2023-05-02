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
            ForEach(0..<vm.httpHandlers.count, id: \.self) { i in
                let handler = vm.httpHandlers[i]
                let isEnabled = vm.defaultHttpHandler.bundleIdentifier != handler.bundleIdentifier
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
            .disabled(true)
            
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
