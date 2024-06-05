//
//  SettingsView.swift
//  BrowserChanger2
//
//  Created by mbp2 hilfy on 01.05.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var store: SettingsStore
    
    @State var tab: SettingsTab = .exceptions
    
    var body: some View {
        content
            .environmentObject(store)
            .onAppear {
                store.isOpened = true
            }
            .onDisappear {
                store.isOpened = false
            }
            .navigationTitle("Settings")
    }
    
    var content: some View {
        VStack(spacing: 10) {
            tabPicker
            
            tabContent
        }
        .padding()
        .overlay(alignment: .bottomTrailing) {
            SettingsVersionView(text: store.appVersion)
        }
    }
    
    var tabPicker: some View {
        Picker("", selection: $tab) {
            ForEach(SettingsTab.allCases) {
                Text($0.displayValue)
                    .tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(maxWidth: 300)
    }
    
    @ViewBuilder
    var tabContent: some View {
        switch tab {
        case .exceptions:
            SettingsExceptionsView()
        case .statusBar:
            SettingsStatusBarView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsStore.shared)
    }
}
