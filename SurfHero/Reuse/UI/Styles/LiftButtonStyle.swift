//
//  LiftButtonStyle.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 08.04.2024.
//

import SwiftUI

struct LiftButtonStyle: ButtonStyle {
    @State var hovering: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(hovering ? 1.05 : 1, anchor: .center)
            .animation(.easeInOut(duration: 0.1), value: hovering)
            .onHover { hovering in
                self.hovering = hovering
            }
    }
}
extension ButtonStyle where Self == LiftButtonStyle {
    static var lift: LiftButtonStyle {
        LiftButtonStyle()
    }
}

#Preview {
    Button("button", systemImage: "xmark") {}
        .buttonStyle(.lift)
        .padding()
}

struct LiftIconButtonStyle: ButtonStyle {
    let icon: Image
    var size: CGFloat = 16
    
    @State var hovering: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 4) {
            Color.clear
                .frame(width: size, height: size)
            
            configuration.label
                .fontDesign(.rounded)
        }
        .overlay(alignment: .leading) {
            let iconSize = hovering ? size * 1.2 : size
            
            icon
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .offset(x: hovering ? -(iconSize / 10) : 0)
        }
        .animation(.easeInOut(duration: 0.1), value: hovering)
        .onHover { hovering in
            self.hovering = hovering
        }
    }
}
extension ButtonStyle where Self == LiftIconButtonStyle {
    static func liftIcon(_ icon: Image, size: CGFloat = 16) -> LiftIconButtonStyle {
        LiftIconButtonStyle(icon: icon, size: size)
    }
}

#Preview {
    Button("Safari") {}
        .buttonStyle(
            .liftIcon(
                Image(nsImage: NSWorkspace.shared.getIcon(application: "Safari") ?? NSImage())
            )
        )
        .padding()
}
