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
