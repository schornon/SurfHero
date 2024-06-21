//
//  StatusBarIcon.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 05.06.2024.
//

import SwiftUI

struct StatusBarIcon: View {
    @EnvironmentObject var settingsStore: SettingsStore
    @Environment(\.colorScheme) var colorScheme
    
    var handlerIcon: NSImage? {
        guard settingsStore.statusBarHandlerIcon else { return nil }
        let handler = settingsStore.currentHttpHandler
        let icon = handler.icon
        icon?.size = .init(width: 16, height: 16)
        if settingsStore.statusBarHandlerIconMonochrome {
            return icon?.monochrome()
        }
        return icon
    }
    
    var windowIcon: NSImage {
        //let img = NSImage(named: "sh-window-icon") ?? NSImage()
        let img = NSImage(systemSymbolName: "macwindow", accessibilityDescription: nil) ?? NSImage()
        let ratio = img.size.height / img.size.width
        img.size.height = 16
        img.size.width = 16 / ratio
        return img.tint(color: windowIconColor)
    }
    
    var windowIconColor: NSColor {
        colorScheme == .light ? .black : .white
    }
    
    var combinedIcon: NSImage {
        let size = CGSize(width: 22, height: 16)
        let combined = NSImage(size: size, flipped: false) { rect in
            windowIcon.draw(
                at: .zero,
                from: NSRect(origin: .zero, size: windowIcon.size),
                operation: .sourceOver, fraction: 1.0
            )
            handlerIcon?.draw(
                at: NSPoint(x: 6, y: -1),
                from: NSRect(x: 0, y: 0, width: 16, height: 16),
                operation: .sourceOver, fraction: 1.0
            )
            return true
        }
        return combined
    }
    
    var body: some View {
        Image(nsImage: combinedIcon)
    }
}

#Preview {
    StatusBarIcon()
        .environmentObject(SettingsStore.shared)
        .frame(width: 100, height: 100)
}
