//
//  NSWorkspace.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 05.04.2024.
//

import AppKit

extension NSWorkspace {
    func getIcon(file path: String) -> NSImage? {
        guard FileManager.default.fileExists(atPath: path)
        else { return nil }
        
        return icon(forFile: path)
    }

    func getIcon(bundleID: String) -> NSImage? {
        guard
            let path = absolutePathForApplication(withBundleIdentifier: bundleID)
        else { return nil }
        
        return getIcon(file: path)
    }

    func getIcon(application: String) -> NSImage? {
        guard
            let path = fullPath(forApplication: application)
        else { return nil }
        
        return getIcon(file: path)
    }
    
    /// Easily read Info.plist as a Dictionary from any bundle by accessing .infoDictionary on Bundle
    func bundle(for bundleID: String) -> Bundle? {
        guard
            let url = urlForApplication(withBundleIdentifier: bundleID)
        else { return nil }
        
        return Bundle(url: url)
    }
}
