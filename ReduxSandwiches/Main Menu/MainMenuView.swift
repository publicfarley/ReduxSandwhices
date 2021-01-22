//
//  MainMenuView.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-11.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var store: AppStore
    @State private var selectedIndex = 0
    @Environment(\.colorScheme) var systemColorScheme

    
    var body: some View {
        TabView(selection: $selectedIndex) {
            SandwichView()
            .tabItem {
                Image(systemName: "hare")
                Text("Sandwiches")
            }.tag(0)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }.tag(1)
            
            AboutView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
            }.tag(2)
        }.onAppear {
            selectedIndex = store.state.screenState.rawValue
        }.onChange(of: selectedIndex) { value in
            guard let screen = ScreenState(rawValue: value) else {
                return
            }
            
            store.dispatch(
                .navigation(action: .setCurrentScreen(to: screen)))
        }.environment(\.colorScheme, currentColorScheme)
    }
    
    private var currentColorScheme: ColorScheme {
        switch store.state.settingsState.appearanceMode {
        case .system:
            return systemColorScheme
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
