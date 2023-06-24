//
//  SettingsStore.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 01.05.2023.
//

import SwiftUI

final class SettingsStore: ObservableObject {
    
    static let shared = SettingsStore()
    var isOpened: Bool = false
    @Published var httpHandlers: [Bundle] = []
    @AppStorage("httpHandlerExceptions") var httpHandlerExceptions: [String] = ["com.googlecode.iterm2"]
    @Published var currentHttpHandler: Bundle = SettingsStore.currentHttpHandlerBundle()
    private init() {
        synchronize()
    }
    
    private func synchronize() {
        self.httpHandlers = httpHandlerBundles()
        self.currentHttpHandler = Self.currentHttpHandlerBundle()
    }
    
    private func httpHandlerBundles() -> [Bundle] {
        let appUrls = NSWorkspace.shared.urlsForApplications(toOpen: URL(string: "http://")!)
        let bundles = appUrls.compactMap({ Bundle(url: $0) })
        return bundles
    }
    
    static func currentHttpHandlerBundle() -> Bundle! {
        let url = NSWorkspace.shared.urlForApplication(toOpen: URL(string: "http://")!)!
        return Bundle(url: url)!
    }
    
    func setDefaultHttpHandler(_ bundle: Bundle) {
        NSWorkspace.shared.setDefaultApplication(at: bundle.bundleURL, toOpenURLsWithScheme: "http") { [weak self] error in
            DispatchQueue.main.async {
                self?.currentHttpHandler = Self.currentHttpHandlerBundle()
            }
        }
    }
    
    func isException(_ bundle: Bundle) -> Bool {
        httpHandlerExceptions.contains(bundle.bundleIdentifier ?? "")
    }
    
    func toggleHandler(_ bundle: Bundle) {
        let bundleId = bundle.bundleIdentifier ?? ""
        if httpHandlerExceptions.contains(bundleId) {
            httpHandlerExceptions.removeAll(where: {$0 == bundleId})
        } else {
            httpHandlerExceptions.append(bundleId)
        }
    }
}


extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

extension Bundle {
    var displayName: String? {
        infoDictionary?["CFBundleName"] as? String
    }
}
