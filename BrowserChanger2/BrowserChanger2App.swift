//
//  BrowserChanger2App.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 21.03.2023.
//

import SwiftUI

@main
struct BrowserChanger2App: App {
    
    @NSApplicationDelegateAdaptor(Appdelegate.self) var appDelegate
    @StateObject var settingsStore: SettingsStore = .shared
    
    var body: some Scene {
        
        WindowGroup(id: "settings") {
            SettingsView()
                .environmentObject(settingsStore)
        }
        
        MenuBarExtra.init("1", systemImage: "globe.europe.africa") {
            MenuBarView()
        }
        .menuBarExtraStyle(.menu)
    }
}

class Appdelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.windows.first?.close()
    }
}
