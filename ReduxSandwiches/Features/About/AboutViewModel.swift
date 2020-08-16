//
//  AboutViewModel.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-16.
//

import Foundation

protocol AboutViewModel {
    var title: String { get }
    var copyrightMessage: String { get }
    var isAboutViewTheCurrentView: Bool { get }

}

extension AppStore: AboutViewModel {
    var title: String {
        state.aboutState.title
    }
    
    var copyrightMessage: String {
        state.aboutState.copyrightMessage
    }
    
    var isAboutViewTheCurrentView: Bool {
        state.screenState == .aboutDisplay
    }

}
