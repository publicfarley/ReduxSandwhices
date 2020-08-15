//
//  AboutView.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-14.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var store: AppStore
    
    @State private var isCopyrightMessageVisisble = false
    
    var body: some View {
        VStack {
        
            Text(store.state.aboutState.title)
                .font(.headline)
                .padding()
        
            if isCopyrightMessageVisisble {
                Text(store.state.aboutState.copyrightMessage)
                    .font(.body)
                    .padding()
            }
                
        }
        .multilineTextAlignment(.center)
        .onReceive(store.objectWillChange) { _ in
            if store.state.screenState == .aboutDisplay {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    withAnimation(.easeInOut(duration: 1)) {
                        isCopyrightMessageVisisble = true
                    }
                })
            }
        }
    }
}
