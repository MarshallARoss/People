//
//  SettingsView.swift
//  People
//
//  Created by Marshall  on 8/25/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
           haptics
            }
            .navigationTitle("Settings")
        }
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticEnabled)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
