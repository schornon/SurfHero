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
    @AppStorage("httpHandlerExceptions") var httpHandlerExceptions: [String] = ["com.googlecode.iterm2"]
    private init() {
        
    }
    
    private func save() {
        
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
