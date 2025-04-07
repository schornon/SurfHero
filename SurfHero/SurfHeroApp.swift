//
//  SurfHeroApp.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 21.03.2023.
//

import SwiftUI

@main
struct SurfHeroApp: App {
    
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
            StatusBarIcon()
                .environmentObject(settingsStore)
        }

    }
}

class Appdelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        
    }
}
