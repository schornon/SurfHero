//
//  Array.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 12.06.2025.
//

import Foundation

struct CodableArray<Element: Codable>: RawRepresentable {
    var elements: [Element]
    
    init(elements: [Element]) {
        self.elements = elements
    }

    init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data) else {
            return nil
        }
        self.elements = result
    }

    var rawValue: String {
        guard let data = try? JSONEncoder().encode(elements),
              let result = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return result
    }
}
