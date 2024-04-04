//
//  SettingsVersionView.swift
//  BChan
//
//  Created by Serhii Chornonoh on 04.04.2024.
//

import SwiftUI

struct SettingsVersionView: View {
    let text: String
    
    @State var hovering: Bool = false
    @State var location: CGPoint = .zero
    @GestureState var pointerLocation: CGPoint?
    @GestureState var startLocation: CGPoint?
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
            .onEnded { _ in
                self.location = .zero
            }
    }
    
    var pointerDragGesture: some Gesture {
        DragGesture()
            .updating($pointerLocation) { (value, pointerLocation, transaction) in
                pointerLocation = value.location
            }
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 9, weight: .semibold, design: .rounded))
            .opacity(0.4)
            .padding(2)
            .onHover { hovering in
                self.hovering = hovering
                if hovering {
                    self.location = CGPoint(x: .random(in: -200...0), y: 0)
                }
            }
            .offset(x: location.x)
            .foregroundColor(hovering ? .orange : .black)
            .gesture(
                dragGesture.simultaneously(with: pointerDragGesture)
            )
            .animation(.bouncy(duration: 0.2), value: location)
            .animation(.smooth(duration: 0.3), value: hovering)
    }
}

#Preview {
    VStack {
        SettingsVersionView(text: "v.1.2.0 (1)")
    }
    .frame(width: 300, height: 100, alignment: .trailing)
}
