//
//  SettingsView.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-12.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: AppStore
    
    var viewModel: SettingsViewModel {
        store as SettingsViewModel
    }
    
    @State private var appearanceModeIndex = 0

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("APP")) {
                    Picker(selection: $appearanceModeIndex, label: Text("Appearance Mode")) {
                        ForEach(0 ..< AppearanceMode.allCases.count) {
                            Text("\(AppearanceMode.allCases[$0].rawValue)")
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
        }.onAppear {
            appearanceModeIndex = viewModel.currentAppearanceMode == .dark ? 0 : 1
        }.onChange(of: appearanceModeIndex, perform: { value in
            let appearanceMode = AppearanceMode.allCases[value]
            viewModel.setAppearanceMode(to: appearanceMode)
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
