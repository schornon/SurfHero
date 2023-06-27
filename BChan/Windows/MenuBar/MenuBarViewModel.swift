//
//  MenuBarViewModel.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 01.05.2023.
//

import SwiftUI
import AppKit
import Combine

final class MenuBarViewModel: ObservableObject {
    
    @Published var settings: SettingsStore = .shared
    var filteredHttpHandlers: [Bundle] {
        let exceptions = settings.httpHandlerExceptions
        return settings.httpHandlers.filter({!exceptions.contains($0.bundleIdentifier ?? "")})
    }
    @Published var currentHttpHandler: Bundle = SettingsStore.currentHttpHandlerBundle()
    var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        setupObservers()
    }
    
    private func setupObservers() {
        settings.objectWillChange
            .sink { [weak self] in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        settings.$currentHttpHandler
            .assign(to: &$currentHttpHandler)
    }
    
    func setDefaultHttpHandler(_ bundle: Bundle) {
        settings.setDefaultHttpHandler(bundle)
    }
    
    func onQuitTap() {
        NSApplication.shared.terminate(nil)
    }
}
