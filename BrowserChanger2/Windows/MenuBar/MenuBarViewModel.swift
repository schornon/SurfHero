//
//  MenuBarViewModel.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 01.05.2023.
//

import SwiftUI
import AppKit

final class MenuBarViewModel: ObservableObject {
    
    let settings: SettingsStore = .shared
    @Published var httpHandlers: [Bundle] = []
    @Published var defaultHttpHandler: Bundle = MenuBarViewModel.defaultHttpHandlerBundle()
    
    init() {
        synchronize()
    }
    
    private func synchronize() {
        let httpHanlerExceptions = settings.httpHandlerExceptions
        self.httpHandlers = httpHandlerBundles().filter({!httpHanlerExceptions.contains($0.bundleIdentifier ?? "")})
        self.defaultHttpHandler = Self.defaultHttpHandlerBundle()
    }
    
    private func httpHandlerBundles() -> [Bundle] {
        let appUrls = NSWorkspace.shared.urlsForApplications(toOpen: URL(string: "http://")!)
        let bundles = appUrls.compactMap({ Bundle(url: $0) })
        return bundles
    }
    
    static func defaultHttpHandlerBundle() -> Bundle! {
        let url = NSWorkspace.shared.urlForApplication(toOpen: URL(string: "http://")!)!
        return Bundle(url: url)!
    }
    
    func setDefaultHttpHandler(_ bundle: Bundle) {
        NSWorkspace.shared.setDefaultApplication(at: bundle.bundleURL, toOpenURLsWithScheme: "http") { [weak self] error in
            DispatchQueue.main.async {
                self?.defaultHttpHandler = Self.defaultHttpHandlerBundle()
            }
        }
    }
    
    func onQuitTap() {
        NSApplication.shared.terminate(nil)
    }
}

extension Bundle {
    var displayName: String? {
        infoDictionary?["CFBundleName"] as? String
    }
}
