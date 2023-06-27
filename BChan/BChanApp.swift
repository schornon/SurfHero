//
//  BChanApp.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 21.03.2023.
//

import SwiftUI

@main
struct BChanApp: App {
    
    @NSApplicationDelegateAdaptor(Appdelegate.self) var appDelegate
    @StateObject var settingsStore: SettingsStore = .shared
    
    var body: some Scene {
        
        WindowGroup(id: "settings") {
            SettingsView()
                .environmentObject(settingsStore)
        }
        .windowResizability(.contentSize)
        
        MenuBarExtra {
            MenuBarView()
        } label: {
            Image(systemName: "macwindow")
        }

    }
}

class Appdelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.windows.first?.close()
    }
}
