//
//  SettingsExceptionsView.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 05.06.2024.
//

import SwiftUI

struct SettingsExceptionsView: View {
    @EnvironmentObject var store: SettingsStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    DescriptionView(included: false)
                        
                    DescriptionView(included: true)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 8)
            
            HandlersList()
        }
    }
    
    struct DescriptionView: View {
        let included: Bool
        let nsImage = NSWorkspace.shared.getIcon(application: "Safari") ?? NSImage()
        var descr: String {
            included ? "included" : "excluded"
        }
        
        var body: some View {
            HStack(spacing: 0) {
                Image(nsImage: nsImage)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .opacity(included ? 1 : 0.5)
                
                Text(" - \(descr)")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.gray)
            }
        }
    }
    
    struct HandlersList: View {
        @EnvironmentObject var store: SettingsStore
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(0..<store.httpHandlers.count, id: \.self) { i in
                    let handler = store.httpHandlers[i]
                    let excepted = store.isException(handler)
                    Row(handler: handler, excepted: excepted) {
                        store.toggleHandler(handler)
                    }
                }
            }
            .frame(width: 200, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.white)
            .cornerRadius(16)
        }
        
        struct Row: View {
            let handler: Bundle
            var excepted: Bool
            let action: () -> Void
            
            var body: some View {
                Button(handler.displayName ?? "") {
                    action()
                }
                .buttonStyle(
                    .liftIcon(
                        Image(nsImage: handler.icon ?? NSImage())
                    )
                )
                .opacity(excepted ? 0.5 : 1)
            }
        }
    }
}

#Preview {
    SettingsExceptionsView()
        .environmentObject(SettingsStore.shared)
}
