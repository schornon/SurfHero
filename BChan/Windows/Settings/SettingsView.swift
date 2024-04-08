//
//  SettingsView.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 01.05.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var store: SettingsStore
    
    var body: some View {
        content
            .onAppear {
                store.isOpened = true
            }
            .onDisappear {
                store.isOpened = false
            }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Exceptions")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                
                HStack(spacing: 16) {
                    ExceptionDescriptionView(included: false)
                        
                    ExceptionDescriptionView(included: true)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 8)
            
            HandlersList()
                .environmentObject(store)
        }
        .padding()
        .overlay(alignment: .topTrailing) {
            SettingsVersionView(text: store.appVersion)
        }
    }
    
    struct ExceptionDescriptionView: View {
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
                Button(action: action) {
                    HStack(spacing: 4) {
                        Image(nsImage: handler.icon ?? NSImage())
                            .resizable()
                            .foregroundColor(excepted ? .red : .green)
                            .frame(width: 16, height: 16)
                        
                        Text(handler.displayName ?? "")
                            .fontDesign(.rounded)
                    }
                    .frame(minWidth: 100, alignment: .leading)
                    .opacity(excepted ? 0.5 : 1)
                }
                .buttonStyle(.lift)
                .tint(.black)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsStore.shared)
    }
}
